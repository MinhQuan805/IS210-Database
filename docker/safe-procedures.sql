CREATE OR REPLACE PROCEDURE update_booking_status (
    p_booking_id IN NUMBER,
    p_new_status IN VARCHAR2
)
IS
    v_current_status bookings.status%TYPE;
BEGIN
    SELECT status
    INTO v_current_status
    FROM bookings
    WHERE id = p_booking_id
    FOR UPDATE NOWAIT;

    IF v_current_status = p_new_status THEN
        RAISE_APPLICATION_ERROR(
            -20200,
            'Booking da o trang thai nay'
        );
    END IF;

    IF v_current_status IN ('CANCELLED', 'CHECKED_OUT') THEN
        RAISE_APPLICATION_ERROR(
            -20201,
            'Khong the thay doi booking'
        );
    END IF;

    UPDATE bookings
    SET status = p_new_status
    WHERE id = p_booking_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20203,
            'Khong tim thay booking'
        );

    WHEN OTHERS THEN
        RAISE;
END;
/