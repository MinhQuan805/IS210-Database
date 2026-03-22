ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = hotel;

-- Tạo sequences cho auto-increment (Oracle không có AUTO_INCREMENT)
CREATE SEQUENCE room_type_images_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE room_type_amenities_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE amenity_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE room_type_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE room_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE booking_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE booking_history_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE daily_price_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seasonal_price_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE policy_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE promotion_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE faq_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE blog_categories_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE blog_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE sales_reports_seq START WITH 1 INCREMENT BY 1;

-- Bảng amenities
CREATE TABLE amenities (
    id NUMBER DEFAULT amenity_seq.NEXTVAL PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    icon VARCHAR2(50),
    category VARCHAR2(50),
    description VARCHAR2(500)
);

-- Bảng promotions
CREATE TABLE promotions (
    id NUMBER DEFAULT promotion_seq.NEXTVAL PRIMARY KEY,
    code VARCHAR2(50) UNIQUE NOT NULL,
    description VARCHAR2(500),
    discount_type VARCHAR2(20) NOT NULL,
    discount_value NUMBER(12,2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    min_nights NUMBER(10,0),
    max_uses NUMBER(10,0),
    used_count NUMBER(10,0) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_promotions_type CHECK (discount_type IN ('PERCENTAGE', 'FIXED')),
    CONSTRAINT chk_promotion_dates CHECK (end_date >= start_date)
);

-- Bảng customers
CREATE TABLE customers (
    id NUMBER DEFAULT customer_seq.NEXTVAL PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL,
    phone VARCHAR2(20),
    id_number VARCHAR2(50),
    nationality VARCHAR2(50) DEFAULT 'Việt Nam',
    date_of_birth DATE,
    address VARCHAR2(500),
    notes VARCHAR2(1000),
    is_vip NUMBER(1) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_customers_is_vip CHECK (is_vip IN (0, 1))
);

-- Bảng room_types
CREATE TABLE room_types (
    id NUMBER DEFAULT room_type_seq.NEXTVAL PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(2000),
    capacity NUMBER(10,0) NOT NULL,
    base_price NUMBER(12,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Bảng room_type_images
CREATE TABLE room_type_images (
    room_type_id NUMBER NOT NULL,
    image_url VARCHAR2(500) NOT NULL,
    CONSTRAINT pk_room_type_images PRIMARY KEY (room_type_id, image_url),
    CONSTRAINT fk_rti_room_type FOREIGN KEY (room_type_id) REFERENCES room_types(id)
);

-- Bảng room_type_amenities
CREATE TABLE room_type_amenities (
    room_type_id NUMBER NOT NULL,
    amenity_id NUMBER NOT NULL,
    CONSTRAINT pk_room_type_amenities PRIMARY KEY (room_type_id, amenity_id),
    CONSTRAINT fk_rta_room_type FOREIGN KEY (room_type_id) REFERENCES room_types(id),
    CONSTRAINT fk_rta_amenity FOREIGN KEY (amenity_id) REFERENCES amenities(id)
);

-- Bảng rooms
CREATE TABLE rooms (
    id NUMBER DEFAULT room_seq.NEXTVAL PRIMARY KEY,
    room_type_id NUMBER NOT NULL,
    room_number VARCHAR2(20) NOT NULL,
    floor NUMBER(10,0),
    status VARCHAR2(20) NOT NULL,
    notes VARCHAR2(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_rooms_room_type FOREIGN KEY (room_type_id) REFERENCES room_types(id),
    CONSTRAINT chk_rooms_status CHECK (status IN ('AVAILABLE', 'OCCUPIED', 'MAINTENANCE', 'RESERVED'))
);

-- Bảng daily_prices
CREATE TABLE daily_prices (
    id NUMBER DEFAULT daily_price_seq.NEXTVAL PRIMARY KEY,
    room_type_id NUMBER NOT NULL,
    price_date DATE NOT NULL,
    price NUMBER(12,2) NOT NULL,
    reason VARCHAR2(500),
    CONSTRAINT fk_dprices_room_type FOREIGN KEY (room_type_id) REFERENCES room_types(id),
    CONSTRAINT uk_dprices_roomtype_date UNIQUE (room_type_id, price_date)
);

-- Bảng seasonal_prices
CREATE TABLE seasonal_prices (
    id NUMBER DEFAULT seasonal_price_seq.NEXTVAL PRIMARY KEY,
    room_type_id NUMBER NOT NULL,
    name VARCHAR2(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price_multiplier NUMBER(10,2) NOT NULL,
    priority NUMBER(10,0) NOT NULL,
    CONSTRAINT fk_sprices_room_type FOREIGN KEY (room_type_id) REFERENCES room_types(id),
    CONSTRAINT chk_seasonal_dates CHECK (end_date >= start_date)
);

-- Bảng bookings
CREATE TABLE bookings (
    id NUMBER DEFAULT booking_seq.NEXTVAL PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    room_id NUMBER NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price NUMBER(12,2) NOT NULL,
    raw_price NUMBER(12,2) NOT NULL,
    discount_amount NUMBER(12,2) NOT NULL,
    status VARCHAR2(20) NOT NULL,
    special_requests VARCHAR2(1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_bookings_customer FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT fk_bookings_room FOREIGN KEY (room_id) REFERENCES rooms(id),
    CONSTRAINT chk_bookings_status CHECK (status IN ('PENDING', 'CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED')),
    CONSTRAINT chk_bookings_dates CHECK (check_out_date > check_in_date)
);

-- Bảng booking_history
CREATE TABLE booking_history (
    id NUMBER DEFAULT booking_history_seq.NEXTVAL PRIMARY KEY,
    booking_id NUMBER NOT NULL,
    action VARCHAR2(50) NOT NULL,
    performed_by VARCHAR2(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    notes VARCHAR2(500),
    CONSTRAINT fk_bhistory_booking FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Bảng policies
CREATE TABLE policies (
    id NUMBER DEFAULT policy_seq.NEXTVAL PRIMARY KEY,
    type VARCHAR2(50) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    content CLOB,
    language VARCHAR2(10),
    version NUMBER(10,0) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_policies_type CHECK (type IN ('CANCELLATION', 'TERMS', 'PRIVACY', 'CHECKIN_CHECKOUT'))
);

-- Bảng payment
CREATE TABLE payment (
   id NUMBER(19,0) DEFAULT payment_seq.NEXTVAL PRIMARY KEY,
   booking_id NUMBER(19,0),
   payment_date TIMESTAMP NOT NULL,
   amount NUMBER(12,2) NOT NULL, 
   status VARCHAR2(20) DEFAULT 'PENDING' NOT NULL,
   CONSTRAINT fk_payment_booking_id FOREIGN KEY (booking_id) REFERENCES bookings(id),
   CONSTRAINT chk_payment_status CHECK (status IN ('SUCCESS', 'PENDING', 'FAILED'))
);

-- Bảng booking_promotions
CREATE TABLE booking_promotions (
    booking_id NUMBER NOT NULL,
    promotion_id NUMBER NOT NULL,
    CONSTRAINT pk_booking_promotions PRIMARY KEY (booking_id, promotion_id),
    CONSTRAINT fk_bpromo_booking FOREIGN KEY (booking_id) REFERENCES bookings(id),
    CONSTRAINT fk_bpromo_promotion FOREIGN KEY (promotion_id) REFERENCES promotions(id)
);

-- Bảng booking_policies
CREATE TABLE booking_policies (
    booking_id NUMBER NOT NULL,
    policy_id NUMBER NOT NULL,
    CONSTRAINT pk_booking_policies PRIMARY KEY (booking_id, policy_id),
    CONSTRAINT fk_bpolicy_booking FOREIGN KEY (booking_id) REFERENCES bookings(id),
    CONSTRAINT fk_bpolicy_policy FOREIGN KEY (policy_id) REFERENCES policies(id)
);

-- Bảng users
CREATE TABLE users (
    id NUMBER DEFAULT user_seq.NEXTVAL PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    username VARCHAR2(100) UNIQUE NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL,
    phone_number VARCHAR2(20),
    password VARCHAR2(255) NOT NULL,
    role VARCHAR2(20) NOT NULL,
    status VARCHAR2(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_users_role CHECK (role IN ('SUPERADMIN', 'ADMIN', 'MANAGER', 'RECEPTIONIST', 'CLIENT')),
    CONSTRAINT chk_users_status CHECK (status IN ('ACTIVE', 'INACTIVE', 'INVITED', 'SUSPENDED'))
);

-- Bảng faqs
CREATE TABLE faqs (
    id NUMBER DEFAULT faq_seq.NEXTVAL PRIMARY KEY,
    question VARCHAR2(500) NOT NULL,
    answer CLOB,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_faqs_active CHECK (is_active IN (0, 1))
);

-- Bảng reviews
CREATE TABLE reviews (
    id NUMBER DEFAULT review_seq.NEXTVAL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    rating NUMBER(2,1) NOT NULL,
    content CLOB,
    status VARCHAR2(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT chk_reviews_rating CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT chk_reviews_status CHECK (status IN ('PENDING', 'REJECTED', 'APPROVED'))
);

-- Bảng review_images
CREATE TABLE review_images (
    review_id NUMBER NOT NULL,
    image_url VARCHAR2(500) NOT NULL,
    CONSTRAINT pk_review_images PRIMARY KEY (review_id, image_url),
    CONSTRAINT fk_rimages_review FOREIGN KEY (review_id) REFERENCES reviews(id)
);

-- Bảng sales_reports
CREATE TABLE sales_reports (
    id NUMBER DEFAULT sales_reports_seq.NEXTVAL PRIMARY KEY,
    report_date DATE NOT NULL UNIQUE,
    total_bookings NUMBER(10,0) DEFAULT 0,
    gross_revenue NUMBER(15,2) DEFAULT 0,
    discount_amount NUMBER(15,2) DEFAULT 0,
    net_revenue NUMBER(15,2) NOT NULL,
    room_occupancy_rate NUMBER(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);


