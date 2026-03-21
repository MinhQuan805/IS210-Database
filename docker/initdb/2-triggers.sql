ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- Ghi nhận create bookings vào booking_history

create or replace TRIGGER trg_booking_ai
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN
    INSERT INTO booking_history (booking_id, action)
    VALUES (:NEW.id, 'Tạo mới');
END;
/

-- Ghi nhận update bookings vào booking_history

create or replace TRIGGER trg_booking_au
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    IF :OLD.status != :NEW.status THEN
        INSERT INTO booking_history (booking_id, action)
        VALUES (:NEW.id, 'Đổi trạng thái từ ' || :OLD.status || ' sang ' || :NEW.status);
    END IF;

    IF :OLD.room_id != :NEW.room_id THEN
        INSERT INTO booking_history (booking_id, action)
        VALUES (:NEW.id, 'Đổi phòng từ ' || :OLD.room_id || ' sang ' || :NEW.room_id);
    END IF;
END;
/

-- Cập nhật rooms.status

create or replace TRIGGER trg_booking_room_status
AFTER INSERT OR UPDATE OF status ON bookings
FOR EACH ROW
BEGIN
    UPDATE rooms
    SET status =
        CASE :NEW.status
            WHEN 'CONFIRMED' THEN 'RESERVED'
            WHEN 'CHECKED_IN' THEN 'OCCUPIED'
            WHEN 'CHECKED_OUT' THEN 'MAINTENANCE'
            ELSE 'AVAILABLE'
        END
    WHERE id = :NEW.room_id;
END;
/

-- Tăng promotions.used_count

CREATE OR REPLACE TRIGGER trg_bpromo_biu
BEFORE INSERT OR UPDATE ON booking_promotions
FOR EACH ROW
DECLARE
    v_used_count NUMBER;
    v_max_uses   NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT used_count, max_uses
        INTO v_used_count, v_max_uses
        FROM promotions
        WHERE id = :NEW.promotion_id
        FOR UPDATE;

        IF v_max_uses IS NOT NULL AND v_used_count >= v_max_uses THEN
            RAISE_APPLICATION_ERROR(-20001, 'Promotion has reached max usage');
        END IF;

        UPDATE promotions
        SET used_count = used_count + 1
        WHERE id = :NEW.promotion_id;
    END IF;

    IF UPDATING THEN
        -- Nếu đổi promotion
        IF :OLD.promotion_id != :NEW.promotion_id THEN

            -- Giảm promotion cũ
            UPDATE promotions
            SET used_count = used_count - 1
            WHERE id = :OLD.promotion_id;

            -- Check promotion mới
            SELECT used_count, max_uses
            INTO v_used_count, v_max_uses
            FROM promotions
            WHERE id = :NEW.promotion_id
            FOR UPDATE;

            IF v_max_uses IS NOT NULL AND v_used_count >= v_max_uses THEN
                RAISE_APPLICATION_ERROR(-20002, 'New promotion exceeded max usage');
            END IF;

            -- Tăng promotion mới
            UPDATE promotions
            SET used_count = used_count + 1
            WHERE id = :NEW.promotion_id;
        END IF;
    END IF;
END;
/

-- Giảm promotions.used_count

CREATE OR REPLACE TRIGGER trg_booking_au_status
AFTER UPDATE OF status ON bookings
FOR EACH ROW
BEGIN
    IF :OLD.status != :NEW.status THEN
        IF :NEW.status IN ('CHECKED_OUT', 'CANCELLED') THEN
            UPDATE promotions p
            SET used_count = used_count - 1
            WHERE p.id IN (
                SELECT bp.promotion_id
                FROM booking_promotions bp
                WHERE bp.booking_id = :NEW.id
            );

        END IF;

    END IF;
END;
/
