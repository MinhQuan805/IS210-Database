ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- 1. sp_create_booking
CREATE OR REPLACE PROCEDURE sp_create_booking (
    p_customer_id IN NUMBER,
    p_room_type_id IN NUMBER,
    p_check_in_date IN DATE,
    p_check_out_date IN DATE,
    p_promotion_code IN VARCHAR2 DEFAULT NULL,
    p_special_requests IN VARCHAR2 DEFAULT NULL,
    o_booking_id OUT NUMBER
)
IS
    v_room_id           NUMBER;
    v_raw_price         NUMBER(12,2);
    v_discount_amount   NUMBER(12,2) := 0;
    v_num_nights        NUMBER;
    v_promotion_id      NUMBER;

    CURSOR c_room IS
        SELECT r.id
        FROM rooms r
        WHERE r.room_type_id = p_room_type_id
          AND r.status != 'MAINTENANCE'
          AND NOT EXISTS (
              SELECT 1 FROM bookings b
              WHERE b.room_id = r.id
                AND b.status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN')
                AND p_check_in_date < b.check_out_date
                AND p_check_out_date > b.check_in_date
          )
        ORDER BY r.floor, r.room_number
        FOR UPDATE SKIP LOCKED;
BEGIN
    v_num_nights := p_check_out_date - p_check_in_date;
    IF v_num_nights <= 0 THEN
        RAISE_APPLICATION_ERROR(-20100, 'Ngày check-out phải sau ngày check-in');
    END IF;

    OPEN c_room;
    FETCH c_room INTO v_room_id;
    IF c_room%NOTFOUND THEN
        CLOSE c_room;
        RAISE_APPLICATION_ERROR(-20101, 'Không còn phòng trống cho loại phòng này trong khoảng thời gian yêu cầu');
    END IF;
    CLOSE c_room;

    v_raw_price := fn_calculate_room_price(p_room_type_id, p_check_in_date, p_check_out_date);

    IF p_promotion_code IS NOT NULL THEN
        v_discount_amount := fn_calculate_promotion_discount(v_raw_price, p_promotion_code, v_num_nights);
        IF v_discount_amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20102, 'Mã khuyến mãi không hợp lệ hoặc đã hết hạn: ' || p_promotion_code);
        END IF;
    END IF;

    INSERT INTO bookings (
        customer_id, room_id, check_in_date, check_out_date,
        raw_price, discount_amount, total_price, status, special_requests
    ) VALUES (
        p_customer_id, v_room_id, p_check_in_date, p_check_out_date,
        v_raw_price, v_discount_amount, 0, 'PENDING', p_special_requests
    ) RETURNING id INTO o_booking_id;

    IF p_promotion_code IS NOT NULL THEN
        SELECT id INTO v_promotion_id FROM promotions WHERE code = UPPER(p_promotion_code);
        INSERT INTO booking_promotions (booking_id, promotion_id)
        VALUES (o_booking_id, v_promotion_id);
    END IF;

    INSERT INTO booking_policies (booking_id, policy_id)
    SELECT o_booking_id, id FROM policies;

    INSERT INTO booking_history (booking_id, action, performed_by, notes)
    VALUES (
        o_booking_id, 
        'CREATED', 
        'SYSTEM',
        'Đặt phòng mới - Loại phòng ID: ' || p_room_type_id ||
        ', Phòng số: ' || v_room_id ||
        ', Từ: ' || TO_CHAR(p_check_in_date, 'DD/MM/YYYY') ||
        ' đến: ' || TO_CHAR(p_check_out_date, 'DD/MM/YYYY')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        IF c_room%ISOPEN THEN
            CLOSE c_room;
        END IF;
        ROLLBACK;
        RAISE;
END sp_create_booking;
/

-- 2. sp_update_booking_status
CREATE OR REPLACE PROCEDURE sp_update_booking_status (
    p_booking_id IN NUMBER,
    p_new_status IN VARCHAR2,
    p_performed_by IN VARCHAR2,
    p_notes IN VARCHAR2 DEFAULT NULL
)
IS
    v_current_status VARCHAR2(20);
    v_room_id        NUMBER;
    v_action         VARCHAR2(50);
BEGIN
    SELECT status, room_id INTO v_current_status, v_room_id
    FROM bookings WHERE id = p_booking_id FOR UPDATE;

    IF v_current_status = p_new_status THEN
        RAISE_APPLICATION_ERROR(-20200, 'Booking đã ở trạng thái: ' || p_new_status);
    END IF;

    IF v_current_status = 'CANCELLED' THEN
        RAISE_APPLICATION_ERROR(-20201, 'Không thể thay đổi booking đã bị hủy');
    END IF;

    IF v_current_status = 'CHECKED_OUT' THEN
        RAISE_APPLICATION_ERROR(-20202, 'Không thể thay đổi booking đã trả phòng');
    END IF;

    CASE p_new_status
        WHEN 'CONFIRMED' THEN v_action := 'CONFIRMED';
        WHEN 'CANCELLED' THEN v_action := 'CANCELLED';
        ELSE v_action := 'UPDATED';
    END CASE;

    UPDATE bookings SET status = p_new_status WHERE id = p_booking_id;

    IF p_new_status = 'CANCELLED' THEN
        DELETE FROM booking_promotions WHERE booking_id = p_booking_id;
    END IF;

    INSERT INTO booking_history (booking_id, action, performed_by, notes)
    VALUES (
        p_booking_id,
        v_action,
        p_performed_by,
        NVL(p_notes, 'Cập nhật trạng thái: ' || v_current_status || ' -> ' || p_new_status)
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_update_booking_status;
/

-- 3. sp_process_check_in
CREATE OR REPLACE PROCEDURE sp_process_check_in (
    p_booking_id IN NUMBER,
    p_performed_by IN VARCHAR2
)
IS
    v_current_status VARCHAR2(20);
    v_check_in_date  DATE;
    v_room_id        NUMBER;
BEGIN
    SELECT status, check_in_date, room_id
    INTO v_current_status, v_check_in_date, v_room_id
    FROM bookings
    WHERE id = p_booking_id
    FOR UPDATE;

    IF v_current_status != 'CONFIRMED' THEN
        RAISE_APPLICATION_ERROR(-20300, 'Chỉ có thể check-in khi booking ở trạng thái CONFIRMED. Trạng thái hiện tại: ' || v_current_status);
    END IF;

    IF TRUNC(SYSDATE) < TRUNC(v_check_in_date) - 1 THEN
        RAISE_APPLICATION_ERROR(-20301, 'Chưa đến ngày check-in. Ngày check-in: ' || TO_CHAR(v_check_in_date, 'DD/MM/YYYY'));
    END IF;

    UPDATE bookings
    SET status = 'CHECKED_IN'
    WHERE id = p_booking_id;

    INSERT INTO booking_history (booking_id, action, performed_by, notes)
    VALUES (
        p_booking_id,
        'UPDATED',
        p_performed_by,
        'Check-in thành công - Phòng ID: ' || v_room_id || ' - Thời gian: ' || TO_CHAR(SYSTIMESTAMP, 'DD/MM/YYYY HH24:MI:SS')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_process_check_in;
/

-- 4. sp_process_check_out
CREATE OR REPLACE PROCEDURE sp_process_check_out (
    p_booking_id IN NUMBER,
    p_performed_by IN VARCHAR2
)
IS
    v_current_status VARCHAR2(20);
    v_room_id        NUMBER;
    v_total_price    NUMBER(12,2);
    v_total_paid     NUMBER(12,2);
BEGIN
    SELECT status, room_id, total_price
    INTO v_current_status, v_room_id, v_total_price
    FROM bookings
    WHERE id = p_booking_id
    FOR UPDATE;

    IF v_current_status != 'CHECKED_IN' THEN
        RAISE_APPLICATION_ERROR(-20400, 'Chỉ có thể check-out khi booking ở trạng thái CHECKED_IN. Trạng thái hiện tại: ' || v_current_status);
    END IF;

    SELECT NVL(SUM(amount), 0)
    INTO v_total_paid
    FROM payment
    WHERE booking_id = p_booking_id
      AND status = 'SUCCESS';

    IF v_total_paid < v_total_price THEN
        RAISE_APPLICATION_ERROR(-20401, 'Khách chưa thanh toán đủ. Tổng tiền: ' || v_total_price || ', Đã thanh toán: ' || v_total_paid || ', Còn thiếu: ' || (v_total_price - v_total_paid));
    END IF;

    UPDATE bookings
    SET status = 'CHECKED_OUT'
    WHERE id = p_booking_id;

    INSERT INTO booking_history (booking_id, action, performed_by, notes)
    VALUES (
        p_booking_id,
        'UPDATED',
        p_performed_by,
        'Check-out thành công - Phòng ID: ' || v_room_id || ' - Tổng thanh toán: ' || v_total_paid || ' - Thời gian: ' || TO_CHAR(SYSTIMESTAMP, 'DD/MM/YYYY HH24:MI:SS')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_process_check_out;
/

-- 5. sp_generate_daily_sales_report
CREATE OR REPLACE PROCEDURE sp_generate_daily_sales_report (
    p_report_date IN DATE
)
IS
    v_total_bookings    NUMBER(10,0) := 0;
    v_gross_revenue     NUMBER(15,2) := 0;
    v_discount_amount   NUMBER(15,2) := 0;
    v_net_revenue       NUMBER(15,2) := 0;
    v_total_rooms       NUMBER;
    v_occupied_rooms    NUMBER;
    v_occupancy_rate    NUMBER(5,2) := 0;
    v_report_exists     NUMBER;
BEGIN
    SELECT NVL(COUNT(*), 0),
           NVL(SUM(raw_price), 0),
           NVL(SUM(discount_amount), 0),
           NVL(SUM(total_price), 0)
    INTO v_total_bookings, v_gross_revenue, v_discount_amount, v_net_revenue
    FROM bookings
    WHERE TRUNC(check_out_date) = TRUNC(p_report_date)
      AND status IN ('CHECKED_OUT', 'CHECKED_IN');

    SELECT COUNT(*)
    INTO v_total_rooms
    FROM rooms
    WHERE status != 'MAINTENANCE';

    SELECT COUNT(DISTINCT room_id)
    INTO v_occupied_rooms
    FROM bookings
    WHERE status IN ('CONFIRMED', 'CHECKED_IN')
      AND TRUNC(p_report_date) BETWEEN TRUNC(check_in_date) AND TRUNC(check_out_date) - 1;

    IF v_total_rooms > 0 THEN
        v_occupancy_rate := ROUND((v_occupied_rooms / v_total_rooms) * 100, 2);
    END IF;

    SELECT COUNT(*)
    INTO v_report_exists
    FROM sales_reports
    WHERE report_date = TRUNC(p_report_date);

    IF v_report_exists > 0 THEN
        UPDATE sales_reports
        SET total_bookings = v_total_bookings,
            gross_revenue = v_gross_revenue,
            discount_amount = v_discount_amount,
            net_revenue = v_net_revenue,
            room_occupancy_rate = v_occupancy_rate,
            created_at = CURRENT_TIMESTAMP
        WHERE report_date = TRUNC(p_report_date);
    ELSE
        INSERT INTO sales_reports (
            report_date, total_bookings, gross_revenue,
            discount_amount, net_revenue, room_occupancy_rate
        ) VALUES (
            TRUNC(p_report_date), v_total_bookings, v_gross_revenue,
            v_discount_amount, v_net_revenue, v_occupancy_rate
        );
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_generate_daily_sales_report;
/
