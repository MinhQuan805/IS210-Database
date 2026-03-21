-- ALTER SESSION SET CONTAINER = FREEPDB1;
-- ALTER SESSION SET CURRENT_SCHEMA = hotel;
-- SET DEFINE OFF;

-- CREATE OR REPLACE PROCEDURE generate_sales_report (
--     p_start_date IN DATE DEFAULT TRUNC(SYSDATE),
--     p_end_date   IN DATE DEFAULT TRUNC(SYSDATE)
-- )
-- IS
--     v_date DATE;
--     v_total_bookings NUMBER;
--     v_gross_revenue NUMBER;
--     v_discount_amount NUMBER;
--     v_net_revenue NUMBER;
--     v_total_rooms NUMBER;
--     v_booked_rooms NUMBER;
--     v_occupancy_rate NUMBER;
-- BEGIN
--     v_date := TRUNC(p_start_date);

--     WHILE v_date <= TRUNC(p_end_date) LOOP

--         -- Tổng số booking trong ngày
--         SELECT COUNT(*)
--         INTO v_total_bookings
--         FROM bookings
--         WHERE v_date BETWEEN check_in_date AND check_out_date - 1;

--         -- Doanh thu
--         SELECT 
--             NVL(SUM(raw_price), 0),
--             NVL(SUM(discount_amount), 0),
--             NVL(SUM(total_price), 0)
--         INTO 
--             v_gross_revenue,
--             v_discount_amount,
--             v_net_revenue
--         FROM bookings
--         WHERE v_date BETWEEN check_in_date AND check_out_date - 1;

--         -- Tổng số phòng
--         SELECT COUNT(*) INTO v_total_rooms FROM rooms;

--         -- Số phòng được sử dụng
--         SELECT COUNT(DISTINCT room_id)
--         INTO v_booked_rooms
--         FROM bookings
--         WHERE v_date BETWEEN check_in_date AND check_out_date - 1;

--         -- Tỷ lệ sử dụng
--         IF v_total_rooms > 0 THEN
--             v_occupancy_rate := (v_booked_rooms / v_total_rooms) * 100;
--         ELSE
--             v_occupancy_rate := 0;
--         END IF;

--         -- Cập nhật
--         MERGE INTO sales_reports sr
--         USING (SELECT v_date AS report_date FROM dual) tmp
--         ON (sr.report_date = tmp.report_date)
--         -- Update khi bị trùng
--         WHEN MATCHED THEN
--             UPDATE SET
--                 total_bookings     = v_total_bookings,
--                 gross_revenue      = v_gross_revenue,
--                 discount_amount    = v_discount_amount,
--                 net_revenue        = v_net_revenue,
--                 room_occupancy_rate= v_occupancy_rate
--         -- Thêm mới
--         WHEN NOT MATCHED THEN
--             INSERT (
--                 report_date,
--                 total_bookings,
--                 gross_revenue,
--                 discount_amount,
--                 net_revenue,
--                 room_occupancy_rate
--             )
--             VALUES (
--                 v_date,
--                 v_total_bookings,
--                 v_gross_revenue,
--                 v_discount_amount,
--                 v_net_revenue,
--                 v_occupancy_rate
--             );

--         v_date := v_date + 1;
--     END LOOP;

--     COMMIT;
-- END;
-- /


-- -- Chạy theo ngày
-- BEGIN
--     generate_sales_report(
--         DATE '2026-01-01',
--         DATE '2026-03-01'
--     );
-- END;
-- /

-- -- Chạy ngày hôm nay
-- -- BEGIN
-- --     generate_sales_report;
-- -- END;
-- -- /

-- -- Chạy theo ngày
-- -- BEGIN
-- --     generate_sales_report(
-- --         DATE '2026-01-01',
-- --         DATE '2026-01-05'
-- --     );
-- -- END;
-- -- /

-- create or replace TRIGGER trg_booking_calc_price
-- BEFORE INSERT OR UPDATE ON bookings
-- FOR EACH ROW
-- DECLARE
--     v_base_price        NUMBER;
--     v_price             NUMBER;
--     v_raw               NUMBER := 0;
--     v_multiplier        NUMBER := 1;
--     v_discount          NUMBER := 0;
--     v_nights            NUMBER;
--     v_room_type_id      NUMBER;
--     v_current_date      DATE;
-- BEGIN
--     -- Lấy room_type_id từ room
--     SELECT room_type_id
--     INTO v_room_type_id
--     FROM rooms
--     WHERE id = :NEW.room_id;

--     -- Lấy base_price của room_type
--     SELECT base_price
--     INTO v_base_price
--     FROM room_types
--     WHERE id = v_room_type_id;

--     v_nights := :NEW.check_out_date - :NEW.check_in_date;

--     -- Lặp từng ngày
--     FOR i IN 0 .. v_nights - 1 LOOP
--         v_price := v_base_price;
--         v_multiplier := 1;

--         v_current_date := :NEW.check_in_date + i;

--         -- Daily price
--         BEGIN
--             SELECT price
--             INTO v_price
--             FROM daily_prices
--             WHERE room_type_id = v_room_type_id
--               AND EXTRACT(DAY FROM price_date) = EXTRACT(DAY FROM v_current_date)
--               AND EXTRACT(MONTH FROM price_date) = EXTRACT(MONTH FROM v_current_date);
--         EXCEPTION
--             WHEN NO_DATA_FOUND THEN NULL;
--         END;

--         -- Seasonal price
--         BEGIN
--             SELECT price_multiplier
--             INTO v_multiplier
--             FROM (
--                 SELECT price_multiplier
--                 FROM seasonal_prices
--                 WHERE room_type_id = v_room_type_id
--                   AND v_current_date BETWEEN start_date AND end_date
--                 ORDER BY priority DESC
--             )
--             WHERE ROWNUM = 1;
--         EXCEPTION
--             WHEN NO_DATA_FOUND THEN
--                 v_multiplier := 1;
--         END;

--         v_raw := v_raw + (v_price * v_multiplier);
--     END LOOP;

--     -- Promotion
--     BEGIN
--         FOR promo IN (
--             SELECT p.*
--             FROM promotions p
--             JOIN booking_promotions bp ON p.id = bp.promotion_id
--             WHERE bp.booking_id = :NEW.id
--               AND p.is_active = 1
--               AND SYSDATE BETWEEN p.start_date AND p.end_date
--         ) LOOP
--             IF promo.discount_type = 'PERCENTAGE' THEN
--                 v_discount := v_discount + (v_raw * promo.discount_value / 100);
--             ELSIF promo.discount_type = 'FIXED' THEN
--                 v_discount := v_discount + promo.discount_value;
--             END IF;
--         END LOOP;
--     END;

--     -- Cập nhật vào booking
--     :NEW.raw_price := v_raw;
--     :NEW.discount_amount := v_discount;
--     :NEW.total_price := GREATEST(v_raw - v_discount, 0);

-- END;
-- /
