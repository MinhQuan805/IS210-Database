ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;
SET DEFINE OFF;

-- --- amenities

Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Wifi miễn phí','WFI','Tiện nghi cơ bản','Internet tốc độ cao phủ sóng toàn bộ khách sạn');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Bể bơi ngoài trời','POOL','Tiện nghi giải trí','Hồ bơi vô cực view thành phố với khu vực tắm nắng');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Phòng gym','GYM','Tiện nghi thể thao','Trang bị máy tập hiện đại và huấn luyện viên chuyên nghiệp');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Nhà hàng buffet','REST','Ẩm thực','Phục vụ buffet sáng với đa dạng món ăn Á - Âu');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Bar trên sân thượng','BAR','Tiện nghi giải trí','Thưởng thức cocktail với view toàn cảnh thành phố');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Spa & Massage','SPA','Chăm sóc sức khỏe','Dịch vụ massage thư giãn cùng các liệu pháp trị liệu cao cấp');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Phòng xông hơi','SAU','Chăm sóc sức khỏe','Phòng xông hơi khô và ướt với hệ thống hiện đại');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Bãi đậu xe','PARK','Tiện nghi cơ bản','Bãi đậu xe rộng rãi có camera an ninh 24/7');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Phòng họp','MEET','Tiện nghi công vụ','Trang bị màn hình LED và thiết bị hội nghị đầy đủ');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Trung tâm hội nghị','CONF','Tiện nghi công vụ','Sức chứa lên đến 500 khách với âm thanh ánh sáng chuyên nghiệp');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Phòng trẻ em','KIDS','Tiện nghi gia đình','Khu vui chơi an toàn với nhân viên trông trẻ chuyên nghiệp');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Dịch vụ phòng','ROOM','Tiện nghi cơ bản','Phục vụ đồ ăn thức uống 24/7 tại phòng nghỉ');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Giặt ủi','LAUN','Tiện nghi cơ bản','Dịch vụ giặt là và ủi đồ nhanh chóng trong ngày');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Sân vườn','GARD','Tiện nghi giải trí','Khuôn viên cây xanh rộng rãi với ghế thư giãn ngoài trời');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Xông hơi khô','DRSA','Chăm sóc sức khỏe','Phòng xông hơi khô với đá quý và tinh dầu thiên nhiên');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Quầy lễ tân 24h','DESK','Tiện nghi cơ bản','Đội ngũ lễ tân hỗ trợ khách hàng 24 giờ mỗi ngày');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Thang máy','ELEV','Tiện nghi cơ bản','Thang máy tốc độ cao đáp ứng nhu cầu di chuyển dễ dàng');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Câu lạc bộ đêm','CLUB','Tiện nghi giải trí','Không gian âm nhạc sôi động với DJ chuyên nghiệp');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Sân tennis','TENI','Tiện nghi thể thao','Sân tennis đạt chuẩn quốc tế với hệ thống đèn chiếu sáng');
Insert into AMENITIES (NAME,ICON,CATEGORY,DESCRIPTION) values ('Dịch vụ xe đưa đón','SHUT','Tiện nghi cơ bản','Xe đưa đón sân bay và các địa điểm du lịch lân cận');

-- -- promotions

Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('SUMMER2026','Chương trình hè rực rỡ - giảm giá cho kỳ nghỉ hè 2026','PERCENTAGE',15,to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),2,100,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('WELCOME2026','Ưu đãi chào mừng khách hàng mới lần đầu đặt phòng','FIXED',300000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,50,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('TET2026','Khuyến mãi đặc biệt dịp Tết Nguyên Đán','PERCENTAGE',20,to_date('15-JAN-26','DD-MON-RR'),to_date('25-FEB-26','DD-MON-RR'),3,80,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('WEEKEND2026','Giảm giá cuối tuần cho kỳ nghỉ ngắn ngày','FIXED',200000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,200,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('VIPONLY','Ưu đãi dành riêng cho khách hàng thân thiết','PERCENTAGE',25,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),2,30,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('AUTUMN2026','Chương trình thu vàng - ưu đãi đặc biệt mùa thu','PERCENTAGE',12,to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),2,100,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('EARLYBIRD','Đặt phòng sớm nhận ưu đãi lớn','FIXED',500000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),3,40,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('LASTMINUTE','Siêu ưu đãi phút chót cho khách đặt gần ngày','PERCENTAGE',18,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,60,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('FAMILY2026','Ưu đãi gia đình - giảm giá cho đoàn từ 3 người','FIXED',400000,to_date('01-APR-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),3,50,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('SPRING2026','Chào xuân mới - ưu đãi đặc biệt đầu năm','PERCENTAGE',10,to_date('01-FEB-26','DD-MON-RR'),to_date('30-APR-26','DD-MON-RR'),2,120,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('LONGGSTAY','Giảm giá cho khách lưu trú dài ngày từ 5 đêm','PERCENTAGE',22,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),5,30,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('ROMANCE','Ưu đãi lãng mạn dành cho các cặp đôi','FIXED',350000,to_date('01-FEB-26','DD-MON-RR'),to_date('31-MAR-26','DD-MON-RR'),2,40,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('WINTER2026','Đông ấm áp - ưu đãi đặc biệt mùa đông','PERCENTAGE',15,to_date('01-NOV-26','DD-MON-RR'),to_date('28-FEB-27','DD-MON-RR'),2,100,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('BUSINESS','Ưu đãi dành cho khách công tác','FIXED',250000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,80,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('NATIONAL2026','Quốc khánh 2/9 - ưu đãi đặc biệt','PERCENTAGE',17,to_date('28-AUG-26','DD-MON-RR'),to_date('05-SEP-26','DD-MON-RR'),2,60,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('REPEAT','Ưu đãi tri ân khách hàng đã từng lưu trú','FIXED',450000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,50,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('SUPERSAVE','Siêu tiết kiệm - giảm sâu cho kỳ nghỉ dài ngày','PERCENTAGE',30,to_date('01-MAY-26','DD-MON-RR'),to_date('31-JUL-26','DD-MON-RR'),4,25,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('MIDWEEK','Ưu đãi ngày thường từ thứ 2 đến thứ 5','FIXED',180000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),1,150,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('ANNIV2026','Kỷ niệm 5 năm thành lập - ưu đãi đặc biệt','PERCENTAGE',28,to_date('01-OCT-26','DD-MON-RR'),to_date('31-OCT-26','DD-MON-RR'),2,45,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into promotions (CODE,DESCRIPTION,DISCOUNT_TYPE,DISCOUNT_VALUE,START_DATE,END_DATE,MIN_NIGHTS,MAX_USES,USED_COUNT,CREATED_AT,UPDATED_AT) values ('GROUP2026','Ưu đãi nhóm từ 5 phòng trở lên','FIXED',600000,to_date('01-JAN-26','DD-MON-RR'),to_date('31-DEC-26','DD-MON-RR'),2,20,0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- roome_types

Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Master Single','Phòng master dành cho 1 người với view thành phố và không gian sang trọng',1,2500000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Master Double','Phòng master dành cho 2 người với giường king size và view toàn cảnh',2,3200000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Deluxe Twin','Phòng deluxe với 2 giường đơn phù hợp cho bạn bè hoặc đồng nghiệp',2,2800000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Deluxe Triple','Phòng deluxe rộng rãi với 3 giường đơn hoặc 1 giường đôi + 1 giường đơn',3,3500000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Family Quad','Phòng gia đình với 2 giường đôi phù hợp cho 4 người',4,4200000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Suite Family','Suite cao cấp dành cho gia đình lớn với phòng khách riêng biệt',5,5800000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Premium Suite','Suite hạng sang với 2 phòng ngủ và view biển tuyệt đẹp',6,7500000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOM_TYPES (NAME,DESCRIPTION,CAPACITY,BASE_PRICE,CREATED_AT,UPDATED_AT) values ('Executive Suite','Suite thương gia với bàn làm việc và khu vực tiếp khách sang trọng',2,4800000,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- room_type_images

Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=101');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=102');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=103');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (2,'https://picsum.photos/1000?random=201');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (3,'https://picsum.photos/1000?random=301');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (3,'https://picsum.photos/1000?random=302');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (4,'https://picsum.photos/1000?random=401');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=501');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=502');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=503');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (7,'https://picsum.photos/1000?random=701');
Insert into ROOM_TYPE_IMAGES (ROOM_TYPE_ID,IMAGE_URL) values (7,'https://picsum.photos/1000?random=702');

-- -- room_type_amenities

Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (1,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,5);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (2,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (3,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,11);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,14);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (4,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,6);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,11);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,14);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (5,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,2);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,6);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,7);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,11);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,14);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,15);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (6,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,2);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,5);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,6);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,7);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,11);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,14);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,15);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (7,19);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,1);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,4);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,5);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,8);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,9);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,10);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,12);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,13);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,16);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,17);
Insert into ROOM_TYPE_AMENITIES (ROOM_TYPE_ID,AMENITY_ID) values (8,20);

-- -- rooms

Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (1,'P1.1',1,'AVAILABLE','Phòng view thành phố',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (1,'P1.2',1,'AVAILABLE','Phòng yên tĩnh cuối hành lang',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (1,'P1.3',1,'AVAILABLE','Phòng có cửa sổ lớn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (1,'P1.4',1,'AVAILABLE','Phòng gần thang máy',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (1,'P1.5',1,'AVAILABLE','Phòng góc view đẹp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (2,'P2.1',2,'AVAILABLE','Phòng master giường king',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (2,'P2.2',2,'AVAILABLE','Phòng có ban công',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (2,'P2.3',2,'AVAILABLE','Phòng view hồ bơi',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (2,'P2.4',2,'AVAILABLE','Phòng trang trí sang trọng',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (2,'P2.5',2,'AVAILABLE','Phòng master cao cấp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (3,'P3.1',3,'AVAILABLE','Phòng 2 giường đơn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (3,'P3.2',3,'AVAILABLE','Phòng rộng rãi thoáng mát',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (3,'P3.3',3,'AVAILABLE','Phòng có khu vực làm việc',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (3,'P3.4',3,'AVAILABLE','Phòng view nội khu',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (3,'P3.5',3,'AVAILABLE','Phòng deluxe tiêu chuẩn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (4,'P4.1',4,'AVAILABLE','Phòng 3 người có giường đôi',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (4,'P4.2',4,'AVAILABLE','Phòng phù hợp gia đình nhỏ',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (4,'P4.3',4,'AVAILABLE','Phòng có sofa bed',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (4,'P4.4',4,'AVAILABLE','Phòng thoáng mát nhiều ánh sáng',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (4,'P4.5',4,'AVAILABLE','Phòng deluxe rộng nhất tầng',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (5,'P5.1',5,'AVAILABLE','Phòng 2 giường đôi rộng rãi',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (5,'P5.2',5,'AVAILABLE','Phòng gia đình có bếp nhỏ',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (5,'P5.3',5,'AVAILABLE','Phòng view đẹp yên tĩnh',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (5,'P5.4',5,'AVAILABLE','Phòng có tủ lạnh lớn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (5,'P5.5',5,'AVAILABLE','Phòng gia đình tiêu chuẩn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (6,'P6.1',6,'AVAILABLE','Suite có phòng khách riêng',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (6,'P6.2',6,'AVAILABLE','Suite view toàn cảnh',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (6,'P6.3',6,'AVAILABLE','Suite có bồn tắm massage',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (6,'P6.4',6,'AVAILABLE','Suite sang trọng cao cấp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (6,'P6.5',6,'AVAILABLE','Suite gia đình lớn',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (7,'P7.1',7,'AVAILABLE','Premium Suite 2 phòng ngủ',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (7,'P7.2',7,'AVAILABLE','Premium Suite view biển',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (7,'P7.3',7,'AVAILABLE','Premium Suite có bếp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (7,'P7.4',7,'AVAILABLE','Premium Suite hạng sang',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (7,'P7.5',7,'AVAILABLE','Premium Suite đẳng cấp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (8,'P8.1',8,'AVAILABLE','Executive Suite dành cho doanh nhân',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (8,'P8.2',8,'AVAILABLE','Executive Suite có bàn làm việc',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (8,'P8.3',8,'AVAILABLE','Executive Suite view thành phố',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (8,'P8.4',8,'AVAILABLE','Executive Suite sang trọng',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into ROOMS (ROOM_TYPE_ID,ROOM_NUMBER,FLOOR,STATUS,NOTES,CREATED_AT,UPDATED_AT) values (8,'P8.5',8,'AVAILABLE','Executive Suite đẳng cấp',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- daily_prices

Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (1,to_date('30-APR-26','DD-MON-RR'),3250000,'Giá dịp lễ 30/4 - nhu cầu cao');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (1,to_date('01-MAY-26','DD-MON-RR'),3250000,'Giá dịp lễ 30/4 - nhu cầu cao');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (1,to_date('02-SEP-26','DD-MON-RR'),3000000,'Giá dịp Quốc khánh 2/9');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (1,to_date('24-DEC-26','DD-MON-RR'),3750000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (1,to_date('31-DEC-26','DD-MON-RR'),4000000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (2,to_date('30-APR-26','DD-MON-RR'),4160000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (2,to_date('01-MAY-26','DD-MON-RR'),4160000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (2,to_date('02-SEP-26','DD-MON-RR'),3840000,'Giá dịp Quốc khánh 2/9');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (2,to_date('24-DEC-26','DD-MON-RR'),4800000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (2,to_date('31-DEC-26','DD-MON-RR'),5120000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (3,to_date('01-JAN-26','DD-MON-RR'),3360000,'Giá Tết Dương lịch');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (3,to_date('30-APR-26','DD-MON-RR'),3640000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (3,to_date('01-MAY-26','DD-MON-RR'),3640000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (3,to_date('24-DEC-26','DD-MON-RR'),4200000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (3,to_date('31-DEC-26','DD-MON-RR'),4480000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (4,to_date('30-APR-26','DD-MON-RR'),4550000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (4,to_date('01-MAY-26','DD-MON-RR'),4550000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (4,to_date('02-SEP-26','DD-MON-RR'),4200000,'Giá dịp Quốc khánh 2/9');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (4,to_date('24-DEC-26','DD-MON-RR'),5250000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (4,to_date('31-DEC-26','DD-MON-RR'),5600000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (5,to_date('30-APR-26','DD-MON-RR'),5460000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (5,to_date('01-MAY-26','DD-MON-RR'),5460000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (5,to_date('24-DEC-26','DD-MON-RR'),6300000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (5,to_date('31-DEC-26','DD-MON-RR'),6720000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (6,to_date('30-APR-26','DD-MON-RR'),7540000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (6,to_date('01-MAY-26','DD-MON-RR'),7540000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (6,to_date('24-DEC-26','DD-MON-RR'),8700000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (6,to_date('31-DEC-26','DD-MON-RR'),9280000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (7,to_date('30-APR-26','DD-MON-RR'),9750000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (7,to_date('01-MAY-26','DD-MON-RR'),9750000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (7,to_date('24-DEC-26','DD-MON-RR'),11250000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (7,to_date('31-DEC-26','DD-MON-RR'),12000000,'Giá đêm Giao thừa');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (8,to_date('30-APR-26','DD-MON-RR'),6240000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (8,to_date('01-MAY-26','DD-MON-RR'),6240000,'Giá dịp lễ 30/4');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (8,to_date('02-SEP-26','DD-MON-RR'),5760000,'Giá dịp Quốc khánh 2/9');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (8,to_date('24-DEC-26','DD-MON-RR'),7200000,'Giá đêm Giáng sinh');
Insert into DAILY_PRICES (ROOM_TYPE_ID,PRICE_DATE,PRICE,REASON) values (8,to_date('31-DEC-26','DD-MON-RR'),7680000,'Giá đêm Giao thừa');


-- -- seasonal_prices

Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (1,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (1,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (1,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (1,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (2,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (2,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (2,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (2,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (3,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (3,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (3,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (3,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (4,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (4,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (4,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (4,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (5,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (5,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (5,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (5,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (6,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (6,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.4,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (6,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (6,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (7,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.25,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (7,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.5,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (7,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.85,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (7,'Mùa thấp điểm cuối năm',to_date('01-SEP-26','DD-MON-RR'),to_date('30-NOV-26','DD-MON-RR'),0.8,3);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (8,'Mùa cao điểm du lịch hè',to_date('01-JUN-26','DD-MON-RR'),to_date('31-AUG-26','DD-MON-RR'),1.2,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (8,'Mùa lễ Tết Nguyên Đán',to_date('08-FEB-26','DD-MON-RR'),to_date('28-FEB-26','DD-MON-RR'),1.35,1);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (8,'Mùa hội nghị - khách doanh nhân',to_date('01-OCT-26','DD-MON-RR'),to_date('20-DEC-26','DD-MON-RR'),1.15,2);
Insert into SEASONAL_PRICES (ROOM_TYPE_ID,NAME,START_DATE,END_DATE,PRICE_MULTIPLIER,PRIORITY) values (8,'Mùa thấp điểm',to_date('01-MAR-26','DD-MON-RR'),to_date('31-MAY-26','DD-MON-RR'),0.9,3);


-- -- policies

Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CANCELLATION','Chính sách hủy phòng tiêu chuẩn','Quý khách vui lòng hủy phòng trước 72 giờ so với thời gian nhận phòng để được hoàn lại 100% tiền cọc. Nếu hủy trong vòng 48-72 giờ, quý khách sẽ bị tính phí 50% giá trị đặt phòng. Hủy trong vòng 48 giờ hoặc không đến (no-show), quý khách sẽ bị tính phí 100% giá trị đặt phòng. Trường hợp hủy do bất khả kháng (thiên tai, dịch bệnh) vui lòng cung cấp giấy tờ chứng minh để được xem xét miễn phí hủy.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CANCELLATION','Chính sách hủy phòng linh hoạt','Chính sách hủy linh hoạt áp dụng cho các đặt phòng có giá cao hơn 20% so với giá tiêu chuẩn. Quý khách có thể hủy miễn phí đến 24 giờ trước giờ nhận phòng. Nếu hủy trong vòng 24 giờ hoặc không đến, quý khách sẽ bị tính phí 100% đêm đầu tiên. Đặc biệt, khách VIP và khách đặt trực tiếp qua tổng đài được hủy miễn phí đến 12 giờ trước giờ nhận phòng.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CANCELLATION','Chính sách hủy cao điểm và lễ tết','Áp dụng cho các ngày lễ: 30/4-1/5, 2/9, Tết Nguyên Đán và các dịp cao điểm khác theo thông báo của khách sạn. Hủy phòng trong giai đoạn này cần thông báo trước 7 ngày để được hoàn 100% tiền cọc. Hủy từ 3-7 ngày trước ngày nhận phòng bị tính phí 50% giá trị đặt phòng. Hủy dưới 3 ngày hoặc không đến bị tính phí 100% giá trị toàn bộ đặt phòng. Mọi thay đổi hoặc hủy phòng trong cao điểm vui lòng liên hệ trực tiếp với bộ phận đặt phòng.','vi',2,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('TERMS','Điều khoản đặt phòng chung','Việc đặt phòng được xác nhận khi quý khách thanh toán đặt cọc tối thiểu 30% giá trị đặt phòng hoặc toàn bộ tùy theo chương trình ưu đãi. Quý khách vui lòng cung cấp thông tin cá nhân chính xác bao gồm họ tên, số điện thoại, email và giấy tờ tùy thân khi nhận phòng. Giờ nhận phòng chính thức là 14:00 và trả phòng là 12:00 trưa. Khách sạn có quyền từ chối nhận phòng nếu khách không xuất trình được giấy tờ tùy thân hợp lệ.','vi',3,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('TERMS','Điều khoản về trẻ em và giường phụ','Trẻ em dưới 6 tuổi ngủ chung giường với bố mẹ miễn phí (tối đa 1 trẻ/phòng). Trẻ em từ 6-12 tuổi phụ thu phí 200.000 VND/trẻ/đêm bao gồm ăn sáng. Trẻ em trên 12 tuổi và người lớn thứ 3 trở lên phụ thu phí 400.000 VND/người/đêm bao gồm ăn sáng và giường phụ. Yêu cầu giường phụ cần được thông báo trước khi nhận phòng ít nhất 24 giờ để khách sạn sắp xếp.','vi',2,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('TERMS','Điều khoản thanh toán và bảo mật','Khách sạn chấp nhận thanh toán bằng tiền mặt (VND) và các loại thẻ tín dụng quốc tế Visa, Mastercard, Amex, JCB. Thanh toán qua chuyển khoản ngân hàng vui lòng hoàn tất trước 24 giờ khi nhận phòng và gửi lại xác nhận. Mọi thông tin thẻ tín dụng và dữ liệu cá nhân của khách hàng được bảo mật theo tiêu chuẩn PCI DSS và không được chia sẻ với bên thứ ba khi chưa có sự đồng ý.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('PRIVACY','Chính sách bảo mật thông tin cá nhân','Khách sạn cam kết bảo vệ thông tin cá nhân của quý khách. Chúng tôi thu thập các thông tin cần thiết bao gồm họ tên, địa chỉ email, số điện thoại, số chứng minh nhân dân/hộ chiếu, thông tin thẻ tín dụng cho mục đích đặt phòng, thanh toán và tuân thủ quy định pháp luật. Dữ liệu được lưu trữ an toàn trên hệ thống và chỉ được sử dụng trong phạm vi nội bộ khách sạn.','vi',2,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('PRIVACY','Chính sách sử dụng dữ liệu và marketing','Khách sạn sử dụng email và số điện thoại của quý khách để gửi thông tin xác nhận đặt phòng, cập nhật chương trình khuyến mãi và thông tin dịch vụ mới. Quý khách có quyền từ chối nhận thông tin marketing bằng cách nhấn vào đường link hủy đăng ký trong email hoặc liên hệ tổng đài 1900xxxx. Dữ liệu sẽ được lưu trữ tối đa 5 năm kể từ lần tương tác cuối cùng.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('PRIVACY','Chính sách bảo vệ dữ liệu qua website','Website của khách sạn sử dụng cookie và công nghệ mã hóa SSL để bảo vệ thông tin giao dịch của khách hàng. Quý khách nên đảm bảo kết nối internet an toàn khi thực hiện đặt phòng trực tuyến. Khách sạn không chịu trách nhiệm về việc lộ thông tin do lỗi từ phía khách hàng hoặc do các hình thức tấn công mạng từ bên ngoài. Khuyến nghị quý khách nên đặt phòng qua kênh chính thống của khách sạn.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CHECKIN_CHECKOUT','Quy định nhận phòng','Giờ nhận phòng chính thức bắt đầu từ 14:00 hàng ngày. Quý khách đến sớm hơn có thể gửi hành lý tại quầy lễ tân và sử dụng các tiện ích công cộng của khách sạn. Khi nhận phòng, quý khách vui lòng xuất trình căn cước công dân/hộ chiếu và thẻ tín dụng để đặt cọc (nếu có). Khách sạn yêu cầu đặt cọc tối thiểu 1.000.000 VND/phòng/đêm cho các dịch vụ phát sinh.','vi',2,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CHECKIN_CHECKOUT','Quy định trả phòng','Giờ trả phòng là trước 12:00 trưa. Trả phòng sau 12:00 đến 18:00 sẽ bị tính phí 50% giá phòng/đêm. Trả phòng sau 18:00 sẽ bị tính phí 100% giá phòng/đêm. Quý khách vui lòng thanh toán các khoản phát sinh tại quầy lễ tân trước khi trả phòng. Khách sạn hỗ trợ gửi hành lý miễn phí sau khi trả phòng trong ngày.','vi',2,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CHECKIN_CHECKOUT','Quy định đặc biệt cho khách quốc tế','Khách quốc tế khi nhận phòng cần xuất trình hộ chiếu còn hiệu lực và visa (nếu có) theo quy định của pháp luật Việt Nam. Thông tin lưu trú sẽ được khai báo với cơ quan công an địa phương theo đúng quy định. Khách sạn hỗ trợ làm thủ tục tạm trú cho khách nước ngoài. Trường hợp không xuất trình được hộ chiếu hợp lệ, khách sạn có quyền từ chối nhận phòng.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into POLICIES (TYPE,TITLE,CONTENT,LANGUAGE,VERSION,UPDATED_AT) values ('CANCELLATION','Chính sách hủy cho khách đoàn và sự kiện','Áp dụng cho các đoàn từ 5 phòng trở lên hoặc đặt phòng kèm tổ chức sự kiện. Hủy phòng cần thông báo trước 14 ngày để được hoàn 100% tiền cọc. Hủy từ 7-14 ngày trước ngày đến bị tính phí 50% tổng giá trị đặt phòng. Hủy dưới 7 ngày hoặc giảm số lượng phòng so với cam kết sẽ bị tính phí 100% giá trị phòng hủy/giảm. Các điều khoản này sẽ được ghi rõ trong hợp đồng đặt phòng đoàn.','vi',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- users

Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Vũ','Thị Phương Linh','vuthiphuonglinh','20521541@gm.uit.edu.vn','xxxxxxxx','123','SUPERADMIN','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Cao','Thái Bảo','caothaibao','24520145@gm.uit.edu.vn','xxxxxxxx','123','SUPERADMIN','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Võ','Minh Quân','vominhquan','24521459@gm.uit.edu.vn','xxxxxxxx','123','SUPERADMIN','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Nguyễn','Minh Thắng','nguyenminhthang','24521607@gm.uit.edu.vn','xxxxxxxx','123','SUPERADMIN','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Trần','Hoàng Nam','tranhoangnam','hoangnam.tran@hotel.com','0901234505','123','ADMIN','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Lê','Thị Thanh Thảo','lethithanhthao','thanhthao.le@hotel.com','0901234506','123','MANAGER','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Phạm','Văn Đức','phamvanduc','vanduc.pham@hotel.com','0901234507','123','MANAGER','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Ngô','Thị Minh Tâm','ngothiminhram','minhtam.ngo@hotel.com','0901234508','123','MANAGER','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đặng','Hữu Phước','danghuuphuoc','huuphuoc.dang@hotel.com','0901234509','123','MANAGER','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Bùi','Thị Ngọc Lan','buithingoclan','ngoclan.bui@hotel.com','0901234510','123','MANAGER','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Hoàng','Minh Tuấn','hoangminhtuan','minhtuan.hoang@hotel.com','0901234511','123','RECEPTIONIST','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đỗ','Thị Hồng Nhung','dothihongnhung','hongnhung.do@hotel.com','0901234512','123','RECEPTIONIST','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Vũ','Thị Thu Thủy','vuthithuthuy','thuthuy.vu@hotel.com','0901234513','123','RECEPTIONIST','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Nguyễn','Thanh Tùng','nguyenthanhtung','thanhtung.nguyen@hotel.com','0901234514','123','RECEPTIONIST','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Phan','Thị Kim Ngân','phanthikimngan','kimngan.phan@hotel.com','0901234515','123','RECEPTIONIST','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Trần','Văn An','tranvanan','vanan.tran@email.com','0901234516','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Lê','Thị Bình','lethibinh','thibinh.le@email.com','0901234517','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Phạm','Văn Cường','phamvancuong','vancuong.pham@email.com','0901234518','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Ngô','Thị Dung','ngothidung','thidung.ngo@email.com','0901234519','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Hoàng','Văn Đức','hoangvanduc','vanduc.hoang@email.com','0901234520','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đặng','Thị Em','dangthiem','thiem.dang@email.com','0901234521','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Vũ','Văn Phúc','vuvanphuc','vanphuc.vu@email.com','0901234522','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Bùi','Thị Hà','buithiha','thiha.bui@email.com','0901234523','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đỗ','Văn Hùng','dovanhung','vanhung.do@email.com','0901234524','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Nguyễn','Thị Hương','nguyenthihuong','thihuong.nguyen@email.com','0901234525','123','CLIENT','ACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Cao','Thị Ánh Tuyet','caothianhtuyet','anhtuyet.cao@hotel.com','0901234526','123','MANAGER','INACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Võ','Thanh Hải','vothanhhai','thanhhai.vo@hotel.com','0901234527','123','RECEPTIONIST','INACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Nguyễn','Thị Lan Anh','nguyenthilananh','lananh.nguyen@email.com','0901234528','123','CLIENT','INACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Trần','Minh Quân','tranminhquan','minhquan.tran@email.com','0901234529','123','CLIENT','INACTIVE',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Lê','Thị Hồng Nhung','lethihongnhung','hongnhung.le@hotel.com','0901234530','123','MANAGER','INVITED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Phạm','Văn Thịnh','phamvanthinh','vanthinh.pham@hotel.com','0901234531','123','RECEPTIONIST','INVITED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Hoàng','Thị Thu Hằng','hoangthithuhang','thuhang.hoang@email.com','0901234532','123','CLIENT','INVITED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đặng','Văn Minh','dangvanminh','vanminh.dang@email.com','0901234533','123','CLIENT','INVITED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Ngô','Thị Thanh Thảo','ngothithanhthao','thanhthao.ngo@hotel.com','0901234534','123','MANAGER','SUSPENDED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Vũ','Thành Nam','vuthanhnham','thanhnam.vu@hotel.com','0901234535','123','RECEPTIONIST','SUSPENDED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Bùi','Thị Phương Lan','buithiphuonglan','phuonglan.bui@email.com','0901234536','123','CLIENT','SUSPENDED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into USERS (FIRST_NAME,LAST_NAME,USERNAME,EMAIL,PHONE_NUMBER,PASSWORD,ROLE,STATUS,CREATED_AT,UPDATED_AT) values ('Đỗ','Văn Tuấn','dovantuan','tuando@email.com','0901234537','123','CLIENT','SUSPENDED',to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- reviews

Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (16,5,'Phòng sạch sẽ, nhân viên thân thiện, view đẹp. Sẽ quay lại lần sau!','APPROVED',to_timestamp('15-MAR-26 02.30.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (17,5,'Khách sạn rất tuyệt vời! Phòng master rộng rãi, tiện nghi đầy đủ. Buffet sáng ngon.','APPROVED',to_timestamp('16-MAR-26 09.15.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (18,4,'Phòng ổn, vị trí thuận tiện. Nhưng wifi hơi chậm vào giờ cao điểm.','APPROVED',to_timestamp('14-MAR-26 08.45.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (19,5,'Dịch vụ spa tuyệt vời, nhân viên nhiệt tình. Phòng sạch sẽ, đầy đủ tiện nghi.','APPROVED',to_timestamp('12-MAR-26 11.20.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (20,5,'Trải nghiệm tuyệt vời! Bể bơi đẹp, phòng ốc sang trọng. Sẽ giới thiệu bạn bè.','APPROVED',to_timestamp('10-MAR-26 04.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (21,4,'Phòng đẹp, giường ngủ thoải mái. Điều hòa hơi yếu nhưng nhân viên khắc phục nhanh.','APPROVED',to_timestamp('09-MAR-26 10.30.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (22,3,'Phòng bình thường, không có gì nổi bật. Giá hơi cao so với chất lượng.','APPROVED',to_timestamp('08-MAR-26 08.45.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (23,5,'Siêu ưng ý! View biển đẹp, nhân viên lễ tân dễ thương. Sẽ ủng hộ dài dài.','APPROVED',to_timestamp('07-MAR-26 07.15.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (24,5,'Phòng suite rất sang trọng, đúng chuẩn 5 sao. Bữa sáng ngon, đa dạng món.','APPROVED',to_timestamp('06-MAR-26 01.40.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (25,4,'Khách sạn đẹp, vị trí trung tâm. Nhưng giá dịch vụ spa hơi cao.','PENDING',to_timestamp('05-MAR-26 09.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (28,3,'Phòng hơi cũ, cần nâng cấp nội thất. Nhân viên phục vụ tốt.','PENDING',to_timestamp('04-MAR-26 03.30.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (32,5,'Rất hài lòng! Lần đầu đặt phòng nhưng quá ok. Sẽ là khách hàng trung thành.','APPROVED',to_timestamp('18-MAR-26 11.45.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (36,4,'Phòng đẹp, sạch sẽ. Tiện ích đầy đủ. Chỉ hơi ồn vào buổi tối.','REJECTED',to_timestamp('02-MAR-26 09.20.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (6,5,'Là quản lý của khách sạn khác nhưng tôi rất ấn tượng với cách vận hành và chất lượng dịch vụ tại đây.','APPROVED',to_timestamp('01-MAR-26 02.15.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into REVIEWS (USER_ID,RATING,CONTENT,STATUS,CREATED_AT) values (11,5,'Nhân viên lễ tân thân thiện, hỗ trợ nhiệt tình. Phòng ốc sạch sẽ, tiện nghi.','APPROVED',to_timestamp('28-FEB-26 05.30.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'));

-- -- review_images

Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=101');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=102');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (1,'https://picsum.photos/1000?random=103');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (2,'https://picsum.photos/1000?random=201');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (3,'https://picsum.photos/1000?random=301');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (3,'https://picsum.photos/1000?random=302');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (4,'https://picsum.photos/1000?random=401');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=501');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=502');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (5,'https://picsum.photos/1000?random=503');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (7,'https://picsum.photos/1000?random=701');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (7,'https://picsum.photos/1000?random=702');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (8,'https://picsum.photos/1000?random=801');
Insert into REVIEW_IMAGES (REVIEW_ID,IMAGE_URL) values (9,'https://picsum.photos/1000?random=901');


-- -- faqs

Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Giờ nhận phòng và trả phòng như thế nào?','Giờ nhận phòng chính thức là 14:00 và giờ trả phòng là 12:00 trưa. Quý khách có thể gửi hành lý tại quầy lễ tân nếu đến sớm hoặc về muộn. Dịch vụ gửi hành lý hoàn toàn miễn phí.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có hỗ trợ đặt xe sân bay không?','Có. Khách sạn cung cấp dịch vụ xe đưa đón sân bay với chi phí 350.000 VND/lượt cho xe 4 chỗ và 500.000 VND/lượt cho xe 7 chỗ. Quý khách vui lòng thông báo trước ít nhất 24 giờ để chúng tôi sắp xếp.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Trẻ em có được ở miễn phí không?','Trẻ em dưới 6 tuổi ngủ chung giường với bố mẹ được miễn phí (tối đa 1 trẻ/phòng). Trẻ từ 6-12 tuổi phụ thu phí 200.000 VND/trẻ/đêm đã bao gồm ăn sáng. Trẻ trên 12 tuổi tính như người lớn với phụ phí 400.000 VND/người/đêm bao gồm giường phụ và ăn sáng.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có bể bơi và phòng gym không?','Khách sạn có hồ bơi ngoài trời view thành phố mở cửa từ 6:00 - 22:00 và phòng gym hiện đại mở cửa 24/7. Các tiện ích này đều miễn phí cho khách lưu trú. Khách cần mang theo thẻ phòng để sử dụng dịch vụ.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Chính sách hủy phòng như thế nào?','Chính sách hủy phòng linh hoạt: hủy trước 72 giờ so với giờ nhận phòng được hoàn 100% tiền cọc. Hủy từ 48-72 giờ bị tính phí 50% đêm đầu tiên. Hủy dưới 48 giờ hoặc không đến (no-show) bị tính phí 100% đêm đầu tiên. Trong các dịp lễ Tết, vui lòng xem chính sách hủy riêng được ghi chú khi đặt phòng.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có phục vụ ăn sáng không? Giờ ăn sáng mấy giờ?','Có. Khách sạn phục vụ buffet sáng tại nhà hàng tầng 2 từ 6:00 - 10:00 hàng ngày với thực đơn đa dạng Á - Âu. Giá buffet sáng là 250.000 VND/người/lượt đối với khách không bao gồm ăn sáng trong giá phòng.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có chấp nhận thanh toán bằng thẻ không?','Khách sạn chấp nhận thanh toán bằng tiền mặt (VND) và các loại thẻ tín dụng quốc tế như Visa, Mastercard, Amex, JCB. Khách sạn cũng chấp nhận thanh toán qua chuyển khoản ngân hàng và các ví điện tử như Momo, ZaloPay, VNPay.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có cho phép mang theo thú cưng không?','Hiện tại khách sạn không cho phép mang thú cưng vào khu vực phòng nghỉ. Tuy nhiên, chúng tôi có khu vực lưu trú thú cưng riêng với dịch vụ trông giữ chuyên nghiệp với chi phí 300.000 VND/ngày. Quý khách vui lòng liên hệ trước 24 giờ để sắp xếp.',0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có dịch vụ giặt ủi không?','Có. Khách sạn cung cấp dịch vụ giặt ủi với bảng giá niêm yết tại phòng. Thời gian trả đồ trong ngày (nhận trước 9:00 sáng sẽ trả sau 18:00). Dịch vụ giặt khô và ủi nhanh trong vòng 2 giờ có tính phí thêm 50%.',0,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));
Insert into FAQS (QUESTION,ANSWER,IS_ACTIVE,CREATED_AT,UPDATED_AT) values ('Khách sạn có ưu đãi đặc biệt cho khách VIP không?','Có. Khách VIP được hưởng các đặc quyền: giảm giá 10% trên giá phòng, được nâng hạng phòng nếu còn trống, check-in sớm và check-out muộn miễn phí (tùy theo tình trạng phòng), voucher spa 500.000 VND và trái cây chào mừng hàng ngày. Để trở thành khách VIP, quý khách cần có 5 lần lưu trú trở lên tại khách sạn.',1,to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('20-MAR-26 10.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'));

-- customers

Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Nguyễn','Minh Anh','nguyen.minhanh@gmail.com','0901234567','012345678901',to_timestamp('2006-08-15 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hà Nội',NULL,0,to_timestamp('2026-01-05 08:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-05 08:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trần','Bảo Long','tran.baolong@gmail.com','0901234568','123456789012',to_timestamp('2004-03-22 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hồ Chí Minh',NULL,0,to_timestamp('2026-01-08 10:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-08 10:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Lê','Thị Hương','le.huong@gmail.com','0901234569','234567890123',to_timestamp('2007-07-05 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đà Nẵng',NULL,0,to_timestamp('2026-01-12 14:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-12 14:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Phạm','Hoàng Nam','pham.nam@gmail.com','0901234570','345678901234',to_timestamp('2008-11-30 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hải Phòng',NULL,0,to_timestamp('2026-01-15 09:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-15 09:20:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Hoàng','Thị Mai','hoang.mai@gmail.com',NULL,'456789012345',to_timestamp('2006-01-18 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Cần Thơ',NULL,0,to_timestamp('2026-01-18 16:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-18 16:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Ngô','Văn Đức','ngo.duc@gmail.com','0901234571','567890123456',to_timestamp('2004-04-09 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bình Dương',NULL,0,to_timestamp('2026-01-20 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-20 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đặng','Thị Hạnh','dang.hanh@gmail.com',NULL,'678901234567',to_timestamp('2007-06-25 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đồng Nai',NULL,0,to_timestamp('2026-01-22 13:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-22 13:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Vũ','Minh Tuấn','vu.tuan@gmail.com','0901234572','789012345678',to_timestamp('2008-10-14 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Khánh Hòa',NULL,0,to_timestamp('2026-01-24 15:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-24 15:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Bùi','Thị Hồng','bui.hong@gmail.com','0901234573','890123456789',to_timestamp('2006-02-02 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bà Rịa - Vũng Tàu',NULL,0,to_timestamp('2026-01-26 08:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-26 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đỗ','Văn Hùng','do.hung@gmail.com',NULL,'901234567890',to_timestamp('2004-08-27 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Long An',NULL,0,to_timestamp('2026-01-28 10:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-28 10:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trương','Thị Ngọc','truong.ngoc@gmail.com','0901234574','012345678902',to_timestamp('2007-05-11 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Quảng Ninh',NULL,0,to_timestamp('2026-01-30 14:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-30 14:20:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Lý','Quốc Anh','ly.anh@gmail.com','0901234575','123456789013',to_timestamp('2008-12-19 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Lâm Đồng',NULL,0,to_timestamp('2026-02-01 09:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-01 09:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Mai','Thị Tuyết','mai.tuyet@gmail.com',NULL,'234567890124',to_timestamp('2006-07-03 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Thừa Thiên Huế',NULL,0,to_timestamp('2026-02-03 16:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-03 16:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Hà','Văn Thành','ha.thanh@gmail.com','0901234576','345678901235',to_timestamp('2004-09-08 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Nghệ An',NULL,0,to_timestamp('2026-02-05 11:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-05 11:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đinh','Thị Lan','dinh.lan@gmail.com','0901234577','456789012346',to_timestamp('2007-01-21 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Thanh Hóa',NULL,0,to_timestamp('2026-02-07 13:50:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-07 13:50:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trịnh','Văn Tài','trinh.tai@gmail.com',NULL,'567890123457',to_timestamp('2008-03-16 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bình Định',NULL,0,to_timestamp('2026-02-09 08:40:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-09 08:40:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đoàn','Thị Phương','doan.phuong@gmail.com','0901234578','678901234568',to_timestamp('2006-10-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Phú Quốc',NULL,0,to_timestamp('2026-02-10 15:25:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-10 15:25:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Phùng','Văn Hiếu','phung.hieu@gmail.com','0901234579','789012345679',to_timestamp('2004-06-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hà Giang',NULL,0,to_timestamp('2026-02-12 10:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-12 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Chu','Thị Thúy','chu.thuy@gmail.com',NULL,'890123456780',to_timestamp('2007-08-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Lào Cai',NULL,0,to_timestamp('2026-02-14 17:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-14 17:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Vương','Minh Đức','vuong.duc@gmail.com','0901234580','901234567891',to_timestamp('2008-02-24 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Sapa',NULL,0,to_timestamp('2026-02-16 09:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-16 09:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Nguyễn','Văn An','nguyen.an@gmail.com','0901234581','012345678912',to_timestamp('2006-03-15 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hà Nội',NULL,0,to_timestamp('2026-02-18 11:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-18 11:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trần','Thị Bình','tran.binh@gmail.com','0901234582','123456789023',to_timestamp('2007-07-22 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hồ Chí Minh',NULL,0,to_timestamp('2026-02-19 14:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-19 14:20:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Lê','Văn Cường','le.cuong@gmail.com','0901234583','234567890134',to_timestamp('2005-11-10 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đà Nẵng','Khách hàng thân thiết',1,to_timestamp('2026-02-20 08:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-20 08:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Phạm','Thị Dung','pham.dung@gmail.com','0901234584','345678901245',to_timestamp('2008-04-18 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hải Phòng',NULL,0,to_timestamp('2026-02-21 10:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-21 10:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Hoàng','Văn Đức','hoang.duc@gmail.com',NULL,'456789012356',to_timestamp('2006-06-25 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Cần Thơ',NULL,0,to_timestamp('2026-02-22 13:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-22 13:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Ngô','Thị Em','ngo.em@gmail.com','0901234585','567890123467',to_timestamp('2007-09-30 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bình Dương',NULL,0,to_timestamp('2026-02-23 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-23 15:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đặng','Văn Phúc','dang.phuc@gmail.com','0901234586','678901234578',to_timestamp('2005-12-05 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đồng Nai',NULL,0,to_timestamp('2026-02-24 09:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-24 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Vũ','Thị Hà','vu.ha@gmail.com',NULL,'789012345689',to_timestamp('2008-02-12 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Khánh Hòa',NULL,0,to_timestamp('2026-02-25 11:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-25 11:20:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Bùi','Văn Hùng','bui.hung@gmail.com','0901234587','890123456790',to_timestamp('2006-08-19 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bà Rịa - Vũng Tàu',NULL,0,to_timestamp('2026-02-26 14:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-26 14:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đỗ','Thị Hương','do.huong@gmail.com','0901234588','901234567801',to_timestamp('2007-05-27 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Long An',NULL,0,to_timestamp('2026-02-27 16:10:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-27 16:10:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trương','Văn Khải','truong.khai@gmail.com',NULL,'012345678923',to_timestamp('2005-01-03 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Quảng Ninh','Khách VIP',1,to_timestamp('2026-02-28 08:45:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-28 08:45:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Lý','Thị Lan','ly.lan@gmail.com','0901234589','123456789034',to_timestamp('2008-10-14 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Lâm Đồng',NULL,0,to_timestamp('2026-03-01 10:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-01 10:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Mai','Văn Minh','mai.minh@gmail.com','0901234590','234567890145',to_timestamp('2006-03-21 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Thừa Thiên Huế',NULL,0,to_timestamp('2026-01-06 12:15:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-06 12:15:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Hà','Thị Ngọc','ha.ngoc@gmail.com','0901234591','345678901256',to_timestamp('2007-07-29 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Nghệ An',NULL,0,to_timestamp('2026-01-09 15:40:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-09 15:40:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đinh','Văn Phong','dinh.phong@gmail.com',NULL,'456789012367',to_timestamp('2005-11-07 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Thanh Hóa',NULL,0,to_timestamp('2026-01-13 09:50:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-13 09:50:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trịnh','Thị Quyên','trinh.quyen@gmail.com','0901234592','567890123478',to_timestamp('2008-04-16 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bình Định',NULL,0,to_timestamp('2026-01-16 14:25:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-16 14:25:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đoàn','Văn Sơn','doan.son@gmail.com','0901234593','678901234589',to_timestamp('2006-09-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Phú Quốc',NULL,0,to_timestamp('2026-01-19 11:10:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-19 11:10:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Phùng','Thị Tâm','phung.tam@gmail.com',NULL,'789012345690',to_timestamp('2007-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hà Giang',NULL,0,to_timestamp('2026-01-23 16:35:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-23 16:35:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Chu','Văn Thịnh','chu.thinh@gmail.com','0901234594','890123456701',to_timestamp('2005-06-11 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Lào Cai',NULL,0,to_timestamp('2026-01-25 13:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-25 13:20:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Vương','Thị Xuân','vuong.xuan@gmail.com','0901234595','901234567812',to_timestamp('2008-02-18 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Sapa','Thích sản phẩm mới',1,to_timestamp('2026-01-27 09:55:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-27 09:55:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Nguyễn','Thị Ánh','nguyen.anh@gmail.com','0901234596','012345678934',to_timestamp('1995-03-05 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hà Nội',NULL,0,to_timestamp('2026-01-29 12:40:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-29 12:40:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Trần','Văn Bảo','tran.baoo@gmail.com','0901234597','123456789045',to_timestamp('1998-08-12 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hồ Chí Minh',NULL,0,to_timestamp('2026-01-31 15:05:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-31 15:05:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Lê','Thị Cẩm','le.cam@gmail.com',NULL,'234567890156',to_timestamp('1996-11-19 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đà Nẵng',NULL,0,to_timestamp('2026-02-02 10:25:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-02 10:25:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Phạm','Văn Đạt','pham.dat@gmail.com','0901234598','345678901267',to_timestamp('1994-01-24 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Hải Phòng','Khách quen VIP',1,to_timestamp('2026-02-04 14:50:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-04 14:50:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Hoàng','Thị Giang','hoang.giang@gmail.com','0901234599','456789012378',to_timestamp('1999-06-08 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Cần Thơ',NULL,0,to_timestamp('2026-02-06 08:35:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-06 08:35:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Ngô','Văn Hải','ngo.hai@gmail.com',NULL,'567890123489',to_timestamp('1997-10-15 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Bình Dương',NULL,0,to_timestamp('2026-02-08 11:55:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-08 11:55:00','YYYY-MM-DD HH24:MI:SS'));
Insert into CUSTOMERS (FIRST_NAME,LAST_NAME,EMAIL,PHONE,ID_NUMBER,DATE_OF_BIRTH,ADDRESS,NOTES,IS_VIP,CREATED_AT,UPDATED_AT) values ('Đặng','Thị Hạnh','dang.hanh2@gmail.com','0901234600','678901234590',to_timestamp('1995-05-27 00:00:00','YYYY-MM-DD HH24:MI:SS'),'Đồng Nai','Ưu tiên chăm sóc',1,to_timestamp('2026-02-09 17:20:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-09 17:20:00','YYYY-MM-DD HH24:MI:SS'));

-- bookings

Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (1,1,to_timestamp('2026-01-02 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-05 12:00:00','YYYY-MM-DD HH24:MI:SS'),3600000,4000000,400000,'CHECKED_OUT','Phòng yên tĩnh, view đẹp',to_timestamp('2025-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (2,2,to_timestamp('2026-01-03 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-06 12:00:00','YYYY-MM-DD HH24:MI:SS'),8640000,9600000,960000,'CHECKED_OUT',NULL,to_timestamp('2025-12-28 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (3,3,to_timestamp('2026-01-04 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-07 12:00:00','YYYY-MM-DD HH24:MI:SS'),5040000,5600000,560000,'CHECKED_OUT','Cần giường phụ',to_timestamp('2025-12-30 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (4,4,to_timestamp('2026-01-05 14:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-08 12:00:00','YYYY-MM-DD HH24:MI:SS'),6300000,7000000,700000,'CHECKED_OUT',NULL,to_timestamp('2026-01-01 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (5,5,to_timestamp('2026-01-06 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'CHECKED_OUT',NULL,to_timestamp('2026-01-02 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (6,6,to_timestamp('2026-01-07 16:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),5220000,5800000,580000,'CHECKED_OUT','View đẹp, không hút thuốc',to_timestamp('2026-01-03 16:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (7,7,to_timestamp('2026-01-08 13:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-11 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'CHECKED_OUT',NULL,to_timestamp('2026-01-04 09:30:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (8,8,to_timestamp('2026-01-09 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-12 12:00:00','YYYY-MM-DD HH24:MI:SS'),7200000,8000000,800000,'CHECKED_OUT',NULL,to_timestamp('2026-01-05 13:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (9,9,to_timestamp('2026-01-11 15:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-14 12:00:00','YYYY-MM-DD HH24:MI:SS'),8640000,9600000,960000,'CHECKED_OUT','Bánh sinh nhật bất ngờ',to_timestamp('2026-01-07 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (10,10,to_timestamp('2026-01-12 10:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-14 12:00:00','YYYY-MM-DD HH24:MI:SS'),5760000,6400000,640000,'CHECKED_OUT',NULL,to_timestamp('2026-01-08 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (11,11,to_timestamp('2026-01-13 14:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-16 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'CHECKED_OUT',NULL,to_timestamp('2026-01-09 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (12,12,to_timestamp('2026-01-14 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-17 12:00:00','YYYY-MM-DD HH24:MI:SS'),7560000,8400000,840000,'CHECKED_OUT','Chuẩn bị hoa chào mừng',to_timestamp('2026-01-10 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (13,13,to_timestamp('2026-01-16 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-19 12:00:00','YYYY-MM-DD HH24:MI:SS'),8100000,9000000,900000,'CHECKED_OUT',NULL,to_timestamp('2026-01-12 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (14,14,to_timestamp('2026-01-17 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-20 12:00:00','YYYY-MM-DD HH24:MI:SS'),7560000,8400000,840000,'CHECKED_OUT',NULL,to_timestamp('2026-01-13 15:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (15,15,to_timestamp('2026-01-18 10:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-21 12:00:00','YYYY-MM-DD HH24:MI:SS'),7020000,7800000,780000,'CHECKED_OUT','Xin thêm khăn tắm',to_timestamp('2026-01-14 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (16,16,to_timestamp('2026-01-19 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-22 12:00:00','YYYY-MM-DD HH24:MI:SS'),9450000,10500000,1050000,'CHECKED_OUT',NULL,to_timestamp('2026-01-15 13:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (17,17,to_timestamp('2026-01-20 11:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-23 12:00:00','YYYY-MM-DD HH24:MI:SS'),10440000,11600000,1160000,'CHECKED_OUT',NULL,to_timestamp('2026-01-16 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (18,18,to_timestamp('2026-01-21 16:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-24 12:00:00','YYYY-MM-DD HH24:MI:SS'),11250000,12500000,1250000,'CHECKED_OUT','Cần giường phụ cho bé',to_timestamp('2026-01-17 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (19,19,to_timestamp('2026-01-22 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-25 12:00:00','YYYY-MM-DD HH24:MI:SS'),13500000,15000000,1500000,'CHECKED_OUT',NULL,to_timestamp('2026-01-18 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (20,20,to_timestamp('2026-01-23 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-26 12:00:00','YYYY-MM-DD HH24:MI:SS'),12960000,14400000,1440000,'CHECKED_OUT',NULL,to_timestamp('2026-01-19 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (21,21,to_timestamp('2026-01-24 12:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-27 12:00:00','YYYY-MM-DD HH24:MI:SS'),9450000,10500000,1050000,'CHECKED_OUT',NULL,to_timestamp('2026-01-20 12:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (22,22,to_timestamp('2026-01-25 14:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-28 12:00:00','YYYY-MM-DD HH24:MI:SS'),8100000,9000000,900000,'CHECKED_OUT','Chuẩn bị bữa sáng chay',to_timestamp('2026-01-21 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (23,23,to_timestamp('2026-01-26 10:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-29 12:00:00','YYYY-MM-DD HH24:MI:SS'),7020000,7800000,780000,'CHECKED_OUT',NULL,to_timestamp('2026-01-22 15:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (24,24,to_timestamp('2026-01-27 16:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-30 12:00:00','YYYY-MM-DD HH24:MI:SS'),7560000,8400000,840000,'CHECKED_OUT',NULL,to_timestamp('2026-01-23 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (25,25,to_timestamp('2026-01-28 13:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-01-31 12:00:00','YYYY-MM-DD HH24:MI:SS'),8100000,9000000,900000,'CHECKED_OUT','Yêu cầu phòng không hút thuốc',to_timestamp('2026-01-24 13:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (26,26,to_timestamp('2026-02-01 15:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-04 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'CHECKED_IN',NULL,to_timestamp('2026-01-25 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (27,27,to_timestamp('2026-02-02 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-05 12:00:00','YYYY-MM-DD HH24:MI:SS'),5040000,5600000,560000,'CHECKED_IN',NULL,to_timestamp('2026-01-27 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (28,28,to_timestamp('2026-02-03 14:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-06 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'CHECKED_IN','Xin thêm chăn ấm',to_timestamp('2026-01-28 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (29,29,to_timestamp('2026-02-04 10:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-07 12:00:00','YYYY-MM-DD HH24:MI:SS'),4680000,5200000,520000,'CHECKED_IN',NULL,to_timestamp('2026-01-29 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (30,30,to_timestamp('2026-02-05 16:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-08 12:00:00','YYYY-MM-DD HH24:MI:SS'),5670000,6300000,630000,'CHECKED_IN',NULL,to_timestamp('2026-01-30 16:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (31,31,to_timestamp('2026-02-06 13:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-09 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'CHECKED_IN',NULL,to_timestamp('2026-02-01 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (32,32,to_timestamp('2026-02-07 12:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-10 12:00:00','YYYY-MM-DD HH24:MI:SS'),6480000,7200000,720000,'CHECKED_IN','Đặt bữa tối lãng mạn',to_timestamp('2026-02-02 13:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (33,33,to_timestamp('2026-02-08 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-11 12:00:00','YYYY-MM-DD HH24:MI:SS'),6210000,6900000,690000,'CHECKED_IN',NULL,to_timestamp('2026-02-03 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (34,34,to_timestamp('2026-02-09 10:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-12 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'CHECKED_IN',NULL,to_timestamp('2026-02-04 15:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (35,35,to_timestamp('2026-02-10 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-13 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'CHECKED_IN',NULL,to_timestamp('2026-02-05 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (36,36,to_timestamp('2026-02-11 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-14 12:00:00','YYYY-MM-DD HH24:MI:SS'),8640000,9600000,960000,'CHECKED_IN','Cần xe đưa đón sân bay',to_timestamp('2026-02-06 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (37,37,to_timestamp('2026-02-12 16:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-15 12:00:00','YYYY-MM-DD HH24:MI:SS'),8640000,9600000,960000,'CHECKED_IN',NULL,to_timestamp('2026-02-07 12:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (38,38,to_timestamp('2026-02-13 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-16 12:00:00','YYYY-MM-DD HH24:MI:SS'),6480000,7200000,720000,'CONFIRMED',NULL,to_timestamp('2026-02-08 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (39,39,to_timestamp('2026-02-14 10:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-17 12:00:00','YYYY-MM-DD HH24:MI:SS'),5670000,6300000,630000,'CONFIRMED','Chuẩn bị hoa chào mừng',to_timestamp('2026-02-09 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (40,40,to_timestamp('2026-02-16 15:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-19 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'CONFIRMED',NULL,to_timestamp('2026-02-11 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (41,1,to_timestamp('2026-02-17 14:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-20 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'CONFIRMED',NULL,to_timestamp('2026-02-12 15:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (42,2,to_timestamp('2026-02-18 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-21 12:00:00','YYYY-MM-DD HH24:MI:SS'),5040000,5600000,560000,'CONFIRMED','Yêu cầu phòng yên tĩnh',to_timestamp('2026-02-13 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (43,3,to_timestamp('2026-02-19 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-22 12:00:00','YYYY-MM-DD HH24:MI:SS'),7200000,8000000,800000,'PENDING',NULL,to_timestamp('2026-02-14 12:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (44,4,to_timestamp('2026-02-20 16:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-02-23 12:00:00','YYYY-MM-DD HH24:MI:SS'),6750000,7500000,750000,'PENDING',NULL,to_timestamp('2026-02-15 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (45,5,to_timestamp('2026-03-01 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'PENDING','Xin thêm gối cao su',to_timestamp('2026-02-25 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (46,6,to_timestamp('2026-03-01 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),5400000,6000000,600000,'PENDING',NULL,to_timestamp('2026-02-26 14:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (47,7,to_timestamp('2026-03-01 11:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),5040000,5600000,560000,'CANCELLED',NULL,to_timestamp('2026-02-15 08:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (40,8,to_timestamp('2026-03-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),4860000,5400000,540000,'CANCELLED','Khách VIP cần ưu tiên',to_timestamp('2026-02-20 11:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (30,9,to_timestamp('2026-03-01 12:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),4680000,5200000,520000,'CANCELLED',NULL,to_timestamp('2026-02-18 16:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (1,10,to_timestamp('2026-03-01 10:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),4320000,4800000,480000,'CONFIRMED',NULL,to_timestamp('2026-02-22 13:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (2,11,to_timestamp('2026-03-01 09:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-03 12:00:00','YYYY-MM-DD HH24:MI:SS'),4500000,5000000,500000,'CONFIRMED',NULL,to_timestamp('2026-02-23 09:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (3,12,to_timestamp('2026-03-01 14:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-04 12:00:00','YYYY-MM-DD HH24:MI:SS'),8100000,9000000,900000,'CONFIRMED','Chuẩn bị bánh sinh nhật',to_timestamp('2026-02-24 15:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (4,13,to_timestamp('2026-03-01 15:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-04 12:00:00','YYYY-MM-DD HH24:MI:SS'),7560000,8400000,840000,'CONFIRMED',NULL,to_timestamp('2026-02-25 12:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (5,14,to_timestamp('2026-03-01 11:00:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-04 12:00:00','YYYY-MM-DD HH24:MI:SS'),8820000,9800000,980000,'CONFIRMED',NULL,to_timestamp('2026-02-26 10:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into BOOKINGS (CUSTOMER_ID,ROOM_ID,CHECK_IN_DATE,CHECK_OUT_DATE,TOTAL_PRICE,RAW_PRICE,DISCOUNT_AMOUNT,STATUS,SPECIAL_REQUESTS,CREATED_AT) values (6,15,to_timestamp('2026-03-01 13:30:00','YYYY-MM-DD HH24:MI:SS'),to_timestamp('2026-03-04 12:00:00','YYYY-MM-DD HH24:MI:SS'),10260000,11400000,1140000,'CONFIRMED',NULL,to_timestamp('2026-02-27 08:00:00','YYYY-MM-DD HH24:MI:SS'));

-- booking_policies

Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (1, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (1, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (1, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (2, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (2, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (2, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (3, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (3, 5);  -- Children policy (has special request for extra bed)
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (3, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (4, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (4, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (4, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (5, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (5, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (5, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (6, 2);  -- Flexible cancellation (higher price)
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (6, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (6, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (7, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (7, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (7, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (8, 1);  -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (8, 6);  -- Payment terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (8, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (9, 2);  -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (9, 4);  -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (9, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (10, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (10, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (10, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (11, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (11, 5); -- Children policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (11, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (12, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (12, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (12, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (13, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (13, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (13, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (14, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (14, 6); -- Payment terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (14, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (15, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (15, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (15, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (16, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (16, 5); -- Children policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (16, 12); -- International guests policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (17, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (17, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (17, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (18, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (18, 5); -- Children policy (has special request for baby bed)
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (18, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (19, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (19, 6); -- Payment terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (19, 12); -- International guests policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (20, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (20, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (20, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (21, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (21, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (21, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (22, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (22, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (22, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (23, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (23, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (23, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (24, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (24, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (24, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (25, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (25, 7); -- Privacy policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (25, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (26, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (26, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (26, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (27, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (27, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (27, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (28, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (28, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (28, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (29, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (29, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (29, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (30, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (30, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (30, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (31, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (31, 5); -- Children policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (31, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (32, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (32, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (32, 12); -- International guests policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (33, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (33, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (33, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (34, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (34, 6); -- Payment terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (34, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (35, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (35, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (35, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (36, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (36, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (36, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (37, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (37, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (37, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (38, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (38, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (38, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (39, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (39, 8); -- Marketing privacy policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (39, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (40, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (40, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (40, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (41, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (41, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (41, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (42, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (42, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (42, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (43, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (43, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (43, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (44, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (44, 5); -- Children policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (44, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (45, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (45, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (45, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (46, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (46, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (46, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (47, 1); -- Standard cancellation (applies to cancelled booking)
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (47, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (47, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (48, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (48, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (48, 12); -- International guests policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (49, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (49, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (49, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (50, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (50, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (50, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (51, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (51, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (51, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (52, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (52, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (52, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (53, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (53, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (53, 10); -- Check-in policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (54, 1); -- Standard cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (54, 6); -- Payment terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (54, 11); -- Check-out policy
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (55, 2); -- Flexible cancellation
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (55, 4); -- General terms
Insert into BOOKING_POLICIES (BOOKING_ID, POLICY_ID) values (55, 10); -- Check-in policy

-- booking_promotions

-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (1, 2); -- WELCOME2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (2, 10); -- SPRING2026 (10%)
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (3, 4); -- WEEKEND2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (4, 10); -- SPRING2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (5, 2); -- WELCOME2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (6, 7); -- EARLYBIRD
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (7, 4); -- WEEKEND2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (8, 2); -- WELCOME2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (9, 10); -- SPRING2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (10, 7); -- EARLYBIRD
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (12, 12); -- ROMANCE
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (15, 18); -- MIDWEEK
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (16, 9); -- FAMILY2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (17, 14); -- BUSINESS
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (18, 9); -- FAMILY2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (19, 5); -- VIPONLY
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (20, 17); -- SUPERSAVE
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (21, 16); -- REPEAT
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (22, 18); -- MIDWEEK
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (25, 7); -- EARLYBIRD
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (28, 18); -- MIDWEEK
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (32, 12); -- ROMANCE
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (36, 14); -- BUSINESS
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (39, 16); -- REPEAT
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (42, 18); -- MIDWEEK
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (45, 2); -- WELCOME2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (48, 7); -- EARLYBIRD
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (52, 19); -- ANNIV2026
-- Insert into BOOKING_PROMOTIONS (BOOKING_ID, PROMOTION_ID) values (55, 20); -- GROUP2026

-- payment

Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (1, to_timestamp('2025-12-25 08:00:00','YYYY-MM-DD HH24:MI:SS'), 3600000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (2, to_timestamp('2025-12-28 10:00:00','YYYY-MM-DD HH24:MI:SS'), 8640000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (3, to_timestamp('2025-12-30 09:00:00','YYYY-MM-DD HH24:MI:SS'), 5040000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (4, to_timestamp('2026-01-01 11:00:00','YYYY-MM-DD HH24:MI:SS'), 6300000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (5, to_timestamp('2026-01-02 14:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (6, to_timestamp('2026-01-03 16:00:00','YYYY-MM-DD HH24:MI:SS'), 5220000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (7, to_timestamp('2026-01-04 09:30:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (8, to_timestamp('2026-01-05 13:00:00','YYYY-MM-DD HH24:MI:SS'), 7200000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (9, to_timestamp('2026-01-07 10:00:00','YYYY-MM-DD HH24:MI:SS'), 8640000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (10, to_timestamp('2026-01-08 08:00:00','YYYY-MM-DD HH24:MI:SS'), 5760000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (11, to_timestamp('2026-01-09 11:00:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (12, to_timestamp('2026-01-10 14:00:00','YYYY-MM-DD HH24:MI:SS'), 7560000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (13, to_timestamp('2026-01-12 09:00:00','YYYY-MM-DD HH24:MI:SS'), 8100000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (14, to_timestamp('2026-01-13 15:00:00','YYYY-MM-DD HH24:MI:SS'), 7560000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (15, to_timestamp('2026-01-14 10:00:00','YYYY-MM-DD HH24:MI:SS'), 7020000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (16, to_timestamp('2026-01-15 13:00:00','YYYY-MM-DD HH24:MI:SS'), 9450000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (17, to_timestamp('2026-01-16 08:00:00','YYYY-MM-DD HH24:MI:SS'), 10440000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (18, to_timestamp('2026-01-17 14:00:00','YYYY-MM-DD HH24:MI:SS'), 11250000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (19, to_timestamp('2026-01-18 09:00:00','YYYY-MM-DD HH24:MI:SS'), 13500000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (20, to_timestamp('2026-01-19 11:00:00','YYYY-MM-DD HH24:MI:SS'), 12960000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (21, to_timestamp('2026-01-20 12:00:00','YYYY-MM-DD HH24:MI:SS'), 9450000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (22, to_timestamp('2026-01-21 10:00:00','YYYY-MM-DD HH24:MI:SS'), 8100000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (23, to_timestamp('2026-01-22 15:00:00','YYYY-MM-DD HH24:MI:SS'), 7020000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (24, to_timestamp('2026-01-23 08:00:00','YYYY-MM-DD HH24:MI:SS'), 7560000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (25, to_timestamp('2026-01-24 13:00:00','YYYY-MM-DD HH24:MI:SS'), 8100000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (26, to_timestamp('2026-01-25 09:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (27, to_timestamp('2026-01-27 11:00:00','YYYY-MM-DD HH24:MI:SS'), 5040000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (28, to_timestamp('2026-01-28 14:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (29, to_timestamp('2026-01-29 08:00:00','YYYY-MM-DD HH24:MI:SS'), 4680000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (30, to_timestamp('2026-01-30 16:00:00','YYYY-MM-DD HH24:MI:SS'), 5670000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (31, to_timestamp('2026-02-01 10:00:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (32, to_timestamp('2026-02-02 13:00:00','YYYY-MM-DD HH24:MI:SS'), 6480000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (33, to_timestamp('2026-02-03 09:00:00','YYYY-MM-DD HH24:MI:SS'), 6210000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (34, to_timestamp('2026-02-04 15:00:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (35, to_timestamp('2026-02-05 11:00:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (36, to_timestamp('2026-02-06 08:00:00','YYYY-MM-DD HH24:MI:SS'), 8640000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (37, to_timestamp('2026-02-07 12:00:00','YYYY-MM-DD HH24:MI:SS'), 8640000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (38, to_timestamp('2026-02-08 14:00:00','YYYY-MM-DD HH24:MI:SS'), 6480000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (39, to_timestamp('2026-02-09 09:00:00','YYYY-MM-DD HH24:MI:SS'), 5670000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (40, to_timestamp('2026-02-11 10:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (41, to_timestamp('2026-02-12 15:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (42, to_timestamp('2026-02-13 08:00:00','YYYY-MM-DD HH24:MI:SS'), 5040000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (43, to_timestamp('2026-02-14 12:00:00','YYYY-MM-DD HH24:MI:SS'), 7200000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (44, to_timestamp('2026-02-15 09:00:00','YYYY-MM-DD HH24:MI:SS'), 6750000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (45, to_timestamp('2026-02-25 10:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (46, to_timestamp('2026-02-26 14:00:00','YYYY-MM-DD HH24:MI:SS'), 5400000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (47, to_timestamp('2026-02-15 08:00:00','YYYY-MM-DD HH24:MI:SS'), 5040000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (48, to_timestamp('2026-02-20 11:00:00','YYYY-MM-DD HH24:MI:SS'), 4860000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (49, to_timestamp('2026-02-18 16:00:00','YYYY-MM-DD HH24:MI:SS'), 4680000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (50, to_timestamp('2026-02-22 13:00:00','YYYY-MM-DD HH24:MI:SS'), 4320000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (51, to_timestamp('2026-02-23 09:00:00','YYYY-MM-DD HH24:MI:SS'), 4500000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (52, to_timestamp('2026-02-24 15:00:00','YYYY-MM-DD HH24:MI:SS'), 8100000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (53, to_timestamp('2026-02-25 12:00:00','YYYY-MM-DD HH24:MI:SS'), 7560000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (54, to_timestamp('2026-02-26 10:00:00','YYYY-MM-DD HH24:MI:SS'), 8820000, 'SUCCESS');
Insert into PAYMENT (BOOKING_ID, PAYMENT_DATE, AMOUNT, STATUS) values (55, to_timestamp('2026-02-27 08:00:00','YYYY-MM-DD HH24:MI:SS'), 10260000, 'SUCCESS');

