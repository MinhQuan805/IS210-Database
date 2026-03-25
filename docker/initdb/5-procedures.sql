-- ALTER SESSION SET CONTAINER = FREEPDB1;
-- ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- -- Tạo booking mới
-- -- Việc tính discount_amount sẽ tính sau khi áp dụng các promotions

-- CREATE OR REPLACE PROCEDURE create_booking (
--     p_customer_id NUMBER,
--     p_room_id NUMBER,
--     p_check_in DATE,
--     p_check_out DATE
-- )
-- AS
--     v_room_type_id NUMBER;
--     v_raw_price NUMBER;
-- BEGIN
--     -- Lấy room_types.id
--     SELECT room_type_id INTO v_room_type_id
--     FROM rooms
--     WHERE id = p_room_id;

--     -- Lấy raw_price (base_price + extra_price)
--     v_raw_price := calc_raw_price(v_room_type_id, p_check_in, p_check_out);

--     INSERT INTO bookings (
--         customer_id,
--         room_id,
--         check_in_date,
--         check_out_date,
--         raw_price,
--         discount_amount,
--         total_price,
--         status
--     ) VALUES (
--         p_customer_id,
--         p_room_id,
--         p_check_in,
--         p_check_out,
--         v_raw_price,
--         0,
--         v_raw_price,
--         'PENDING'
--     );
-- END;
-- /

-- -- Tính giá giảm giá (discount_amount)

-- CREATE OR REPLACE PROCEDURE calc_discount (
--     p_booking_id NUMBER
-- )
-- AS
--     v_raw_price NUMBER;
--     v_check_in DATE;
--     v_check_out DATE;
--     v_nights NUMBER;
--     v_total_discount NUMBER := 0;
-- BEGIN
--     -- Lấy thông tin booking
--     SELECT raw_price, check_in_date, check_out_date
--     INTO v_raw_price, v_check_in, v_check_out
--     FROM bookings
--     WHERE id = p_booking_id;

--     v_nights := v_check_out - v_check_in;

--     -- Duyệt qua từng promotions của booking_promotions
--     FOR promo IN (
--         SELECT p.*
--         FROM promotions p
--         JOIN booking_promotions bp
--           ON p.id = bp.promotion_id
--         WHERE bp.booking_id = p_booking_id
--     ) LOOP

--         -- Check điều kiện áp dụng
--         IF v_check_in BETWEEN promo.start_date AND promo.end_date
--            AND (promo.min_nights IS NULL OR v_nights >= promo.min_nights)
--            AND (promo.max_uses IS NULL OR promo.used_count < promo.max_uses)
--         THEN
--             DECLARE
--                 v_discount NUMBER := 0;
--             BEGIN
--                 IF promo.discount_type = 'PERCENTAGE' THEN
--                     v_discount := v_raw_price * promo.discount_value / 100;
--                 ELSIF promo.discount_type = 'FIXED' THEN
--                     v_discount := promo.discount_value;
--                 END IF;

--                 v_total_discount := v_total_discount + v_discount;

--                 -- update used_count
--                 UPDATE promotions
--                 SET used_count = used_count + 1
--                 WHERE id = promo.id;

--             END;
--         END IF;

--     END LOOP;

--     -- Không cho discount vượt quá giá gốc
--     v_total_discount := LEAST(v_total_discount, v_raw_price);

--     -- Update booking
--     UPDATE bookings
--     SET discount_amount = v_total_discount,
--         total_price = v_raw_price - v_total_discount
--     WHERE id = p_booking_id;

-- END;
-- /

-- -- Tạo payment mới

-- CREATE OR REPLACE PROCEDURE create_payment (
--     p_booking_id NUMBER,
--     p_amount NUMBER
-- )
-- AS
-- BEGIN
--     INSERT INTO payment (
--         booking_id,
--         payment_date,
--         amount,
--         status
--     ) VALUES (
--         p_booking_id,
--         SYSTIMESTAMP,
--         p_amount,
--         'SUCCESS'
--     );
-- END;
-- /

-- -- Thêm / xóa promotions

-- CREATE OR REPLACE PROCEDURE add_promotions (
--     p_booking_id NUMBER,
--     p_promotion_ids SYS.ODCINUMBERLIST
-- )
-- AS
-- BEGIN
--     FOR i IN 1 .. p_promotion_ids.COUNT LOOP
--         BEGIN
--             INSERT INTO booking_promotions (booking_id, promotion_id)
--             VALUES (p_booking_id, p_promotion_ids(i));
--         EXCEPTION
--             WHEN DUP_VAL_ON_INDEX THEN NULL;
--         END;
--     END LOOP;
-- END;
-- /

-- CREATE OR REPLACE PROCEDURE remove_promotions (
--     p_booking_id NUMBER,
--     p_promotion_ids SYS.ODCINUMBERLIST
-- )
-- AS
-- BEGIN
--     FOR i IN 1 .. p_promotion_ids.COUNT LOOP
--         DELETE FROM booking_promotions
--         WHERE booking_id = p_booking_id
--           AND promotion_id = p_promotion_ids(i);
--     END LOOP;
-- END;
-- /

-- -- Thêm / xóa policies

-- CREATE OR REPLACE PROCEDURE add_policies (
--     p_booking_id NUMBER,
--     p_policy_ids SYS.ODCINUMBERLIST
-- )
-- AS
-- BEGIN
--     FOR i IN 1 .. p_policy_ids.COUNT LOOP
--         BEGIN
--             INSERT INTO booking_policies (booking_id, policy_id)
--             VALUES (p_booking_id, p_policy_ids(i));
--         EXCEPTION
--             WHEN DUP_VAL_ON_INDEX THEN NULL;
--         END;
--     END LOOP;
-- END;
-- /

-- CREATE OR REPLACE PROCEDURE remove_policies (
--     p_booking_id NUMBER,
--     p_policy_ids SYS.ODCINUMBERLIST
-- )
-- AS
-- BEGIN
--     FOR i IN 1 .. p_policy_ids.COUNT LOOP
--         DELETE FROM booking_policies
--         WHERE booking_id = p_booking_id
--           AND policy_id = p_policy_ids(i);
--     END LOOP;
-- END;
-- /

-- -- Tạo sale report
-- -- Chỉ áp dụng lên các bookings.status = 'CANCELLED'

-- CREATE OR REPLACE PROCEDURE create_sales_report (
--     p_start_date DATE,
--     p_end_date DATE
-- )
-- AS
-- BEGIN
--     FOR d IN 0 .. (p_end_date - p_start_date) LOOP
--         DECLARE
--             v_date DATE := p_start_date + d;
--         BEGIN
--             MERGE INTO sales_reports sr
--             USING (
--                 SELECT
--                     v_date AS report_date,
--                     COUNT(*) AS total_bookings,
--                     SUM(raw_price) AS gross_revenue,
--                     SUM(discount_amount) AS discount_amount,
--                     SUM(total_price) AS net_revenue
--                 FROM bookings
--                 WHERE TRUNC(created_at) = v_date
--                   AND status != 'CANCELLED'
--             ) src
--             ON (sr.report_date = src.report_date)
--             -- Report đã tồn tại -> update
--             WHEN MATCHED THEN
--                 UPDATE SET
--                     sr.total_bookings = src.total_bookings,
--                     sr.gross_revenue = src.gross_revenue,
--                     sr.discount_amount = src.discount_amount,
--                     sr.net_revenue = src.net_revenue
--             -- Report chưa tồn tại -> insert
--             WHEN NOT MATCHED THEN
--                 INSERT (
--                     report_date,
--                     total_bookings,
--                     gross_revenue,
--                     discount_amount,
--                     net_revenue
--                 )
--                 VALUES (
--                     src.report_date,
--                     src.total_bookings,
--                     src.gross_revenue,
--                     src.discount_amount,
--                     src.net_revenue
--                 );
--         END;
--     END LOOP;
-- END;
-- /

