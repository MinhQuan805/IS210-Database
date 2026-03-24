ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- Tính giá booking raw (bao gồm room_types.base_price * số ngày)

CREATE OR REPLACE FUNCTION calc_raw_price (
    p_room_type_id NUMBER,
    p_check_in DATE,
    p_check_out DATE
)
RETURN NUMBER
AS
    v_days NUMBER;
    v_base_price NUMBER;
    v_total NUMBER := 0;
BEGIN
    SELECT base_price INTO v_base_price
    FROM room_types
    WHERE id = p_room_type_id;

    v_days := p_check_out - p_check_in;

    FOR d IN 0 .. v_days - 1 LOOP
        DECLARE
            v_date DATE := p_check_in + d;
            v_daily NUMBER := 0;
            v_multiplier NUMBER := 1;
        BEGIN
            -- daily price
            SELECT NVL(price, 0)
            INTO v_daily
            FROM daily_prices
            WHERE room_type_id = p_room_type_id
              AND price_date = v_date
            FETCH FIRST 1 ROWS ONLY;

            -- seasonal price
            SELECT NVL(price_multiplier, 1)
            INTO v_multiplier
            FROM seasonal_prices
            WHERE room_type_id = p_room_type_id
              AND v_date BETWEEN start_date AND end_date
            ORDER BY priority DESC
            FETCH FIRST 1 ROWS ONLY;

            v_total := v_total + (v_base_price + v_daily) * v_multiplier;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_total := v_total + v_base_price;
        END;
    END LOOP;

    RETURN v_total;
END;
/
