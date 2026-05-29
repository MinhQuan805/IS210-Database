ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

CREATE OR REPLACE PROCEDURE update_booking_status (
    p_booking_id IN NUMBER,
    p_new_status IN VARCHAR2
)
IS
    v_old_status bookings.status%TYPE;
BEGIN
    -- Đọc trạng thái hiện tại (không khóa)
    SELECT status
    INTO v_old_status
    FROM bookings
    WHERE id = p_booking_id;

    DBMS_OUTPUT.PUT_LINE(
        'Read booking #' || p_booking_id ||
        ' with status = ' || v_old_status
    );

    -- Delay để transaction khác cũng đọc cùng snapshot
    DBMS_LOCK.SLEEP(3);

    -- Update bằng dữ liệu đã đọc trước đó
    UPDATE bookings
    SET status = p_new_status
    WHERE id = p_booking_id;

    DBMS_OUTPUT.PUT_LINE(
        'Updated booking #' || p_booking_id ||
        ': ' || v_old_status || ' -> ' || p_new_status
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('COMMIT completed');
END;
/
