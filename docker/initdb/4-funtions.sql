ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- 1. fn_calculate_room_price
CREATE OR REPLACE FUNCTION fn_calculate_room_price (
    p_room_type_id IN NUMBER,
    p_check_in_date IN DATE,
    p_check_out_date IN DATE
) RETURN NUMBER
IS
    v_total_price    NUMBER(12,2) := 0;
    v_day_price      NUMBER(12,2);
    v_base_price     NUMBER(12,2);
    v_current_date   DATE;
    v_daily_price    NUMBER(12,2);
    v_multiplier     NUMBER(10,2);
BEGIN
    SELECT base_price INTO v_base_price
    FROM room_types WHERE id = p_room_type_id;

    v_current_date := p_check_in_date;
    WHILE v_current_date < p_check_out_date LOOP
        v_day_price := NULL;

        BEGIN
            SELECT price INTO v_daily_price
            FROM daily_prices
            WHERE room_type_id = p_room_type_id AND price_date = v_current_date;
            v_day_price := v_daily_price;
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN NULL;
        END;

        IF v_day_price IS NULL THEN
            BEGIN
                SELECT price_multiplier INTO v_multiplier
                FROM seasonal_prices
                WHERE room_type_id = p_room_type_id
                  AND v_current_date BETWEEN start_date AND end_date
                ORDER BY priority DESC FETCH FIRST 1 ROW ONLY;
                
                v_day_price := v_base_price * v_multiplier;
            EXCEPTION 
                WHEN NO_DATA_FOUND THEN NULL;
            END;
        END IF;

        IF v_day_price IS NULL THEN
            v_day_price := v_base_price;
        END IF;

        v_total_price := v_total_price + v_day_price;
        v_current_date := v_current_date + 1;
    END LOOP;

    RETURN v_total_price;
END fn_calculate_room_price;
/

-- 2. fn_check_room_availability
CREATE OR REPLACE FUNCTION fn_check_room_availability (
    p_room_id IN NUMBER,
    p_check_in_date IN DATE,
    p_check_out_date IN DATE,
    p_exclude_booking_id IN NUMBER DEFAULT NULL
) RETURN NUMBER
IS
    v_conflict_count NUMBER;
    v_room_status VARCHAR2(20);
BEGIN
    SELECT status INTO v_room_status FROM rooms WHERE id = p_room_id;
    IF v_room_status = 'MAINTENANCE' THEN
        RETURN 0;
    END IF;

    SELECT COUNT(*) INTO v_conflict_count
    FROM bookings
    WHERE room_id = p_room_id
      AND status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN')
      AND (p_exclude_booking_id IS NULL OR id != p_exclude_booking_id)
      AND p_check_in_date < check_out_date
      AND p_check_out_date > check_in_date;

    IF v_conflict_count > 0 THEN 
        RETURN 0;
    ELSE 
        RETURN 1;
    END IF;
END fn_check_room_availability;
/

-- 3. fn_get_available_room_count
CREATE OR REPLACE FUNCTION fn_get_available_room_count (
    p_room_type_id IN NUMBER,
    p_check_in_date IN DATE,
    p_check_out_date IN DATE
) RETURN NUMBER
IS
    v_available_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_available_count
    FROM rooms r
    WHERE r.room_type_id = p_room_type_id
      AND r.status != 'MAINTENANCE'
      AND NOT EXISTS (
          SELECT 1
          FROM bookings b
          WHERE b.room_id = r.id
            AND b.status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN')
            AND p_check_in_date < b.check_out_date
            AND p_check_out_date > b.check_in_date
      );

    RETURN v_available_count;
END fn_get_available_room_count;
/

-- 4. fn_calculate_promotion_discount
CREATE OR REPLACE FUNCTION fn_calculate_promotion_discount (
    p_raw_price IN NUMBER,
    p_promotion_code IN VARCHAR2,
    p_num_nights IN NUMBER DEFAULT NULL
) RETURN NUMBER
IS
    v_discount_amount  NUMBER(12,2) := 0;
    v_discount_type    VARCHAR2(20);
    v_discount_value   NUMBER(12,2);
    v_start_date       DATE;
    v_end_date         DATE;
    v_min_nights       NUMBER(10,0);
    v_max_uses         NUMBER(10,0);
    v_used_count       NUMBER(10,0);
BEGIN
    IF p_promotion_code IS NULL THEN 
        RETURN 0; 
    END IF;

    BEGIN
        SELECT discount_type, discount_value, start_date, end_date,
               min_nights, max_uses, used_count
        INTO v_discount_type, v_discount_value, v_start_date, v_end_date,
             v_min_nights, v_max_uses, v_used_count
        FROM promotions 
        WHERE code = UPPER(p_promotion_code);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RETURN 0;
    END;

    IF TRUNC(SYSDATE) < v_start_date OR TRUNC(SYSDATE) > v_end_date THEN
        RETURN 0;
    END IF;

    IF v_max_uses IS NOT NULL AND v_used_count >= v_max_uses THEN
        RETURN 0;
    END IF;

    IF v_min_nights IS NOT NULL AND p_num_nights IS NOT NULL THEN
        IF p_num_nights < v_min_nights THEN 
            RETURN 0; 
        END IF;
    END IF;

    IF v_discount_type = 'PERCENTAGE' THEN
        v_discount_amount := p_raw_price * (v_discount_value / 100);
    ELSIF v_discount_type = 'FIXED' THEN
        v_discount_amount := LEAST(v_discount_value, p_raw_price);
    END IF;

    RETURN ROUND(v_discount_amount, 2);
END fn_calculate_promotion_discount;
/
