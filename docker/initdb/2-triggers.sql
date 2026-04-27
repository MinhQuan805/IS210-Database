ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

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

-- promotions.used_count

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

-- Kiểm tra số tiền đã thanh toán và cập nhật bookings.status

CREATE OR REPLACE TRIGGER trg_payment_confirm_booking
FOR INSERT OR UPDATE ON payment
COMPOUND TRIGGER

    TYPE t_booking_id_list IS TABLE OF payment.booking_id%TYPE
        INDEX BY PLS_INTEGER;

    v_booking_ids  t_booking_id_list;
    v_count        PLS_INTEGER := 0;

    -- Sau khi mỗi dòng được ghi -> Lấy bookings.id của nó

    AFTER EACH ROW IS
    BEGIN
        IF :NEW.status = 'SUCCESS' THEN
            v_count := v_count + 1;
            v_booking_ids(v_count) := :NEW.booking_id;
        END IF;
    END AFTER EACH ROW;

    -- Sau khi chạy xong statements -> Kiểm tra số tiền đã thanh toán

    AFTER STATEMENT IS
        v_total_paid  NUMBER;
        v_total_price NUMBER;
    BEGIN
        FOR i IN 1 .. v_count LOOP
            -- Tổng tiền đã thanh toán thành công đặt cọc cho booking này
            SELECT NVL(SUM(amount), 0)
            INTO   v_total_paid
            FROM   payment
            WHERE  booking_id = v_booking_ids(i)
              AND  status     = 'SUCCESS';

            -- Tổng giá trị booking
            SELECT total_price
            INTO   v_total_price
            FROM   bookings
            WHERE  id = v_booking_ids(i);

            -- Nếu đã thanh toán đặt cọc đủ 50% -> xác nhận booking
            IF v_total_paid >= v_total_price / 2 THEN

                UPDATE bookings
                SET    status = 'CONFIRMED'
                WHERE  id     = v_booking_ids(i) AND  status = 'PENDING';

                -- Chỉ ghi lịch sử nếu UPDATE thực sự xảy ra
                IF SQL%ROWCOUNT > 0 THEN -- SQL%ROWCOUNT : số dòng được UPDATE
                    INSERT INTO booking_history (
                        booking_id, action, performed_by, notes
                    ) VALUES (
                        v_booking_ids(i),
                        'CONFIRMED',
                        'SYSTEM',
                        'Đã xác nhận đặt phòng'
                    );
                END IF;

            END IF;
        END LOOP;

        -- Reset collection sau mỗi statement
        v_booking_ids.DELETE;
        v_count := 0;
    END AFTER STATEMENT;

END trg_payment_confirm_booking;
/

-- Tính total_price

CREATE OR REPLACE TRIGGER trg_total_price
BEFORE INSERT OR UPDATE ON bookings
FOR EACH ROW
BEGIN
    :NEW.total_price := GREATEST(:NEW.raw_price - :NEW.discount_amount, 0);
END;
/
