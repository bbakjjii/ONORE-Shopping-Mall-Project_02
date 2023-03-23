CREATE TABLE members (
    mem_id   VARCHAR2(20) CONSTRAINT mem_id_pk PRIMARY KEY,
    mem_pw   VARCHAR2(100),
    mem_email   VARCHAR2(100),
    mem_phone   VARCHAR2(20),
    mem_name   VARCHAR2(20),
    mem_zip_code   NUMBER(5),
    mem_street_address   VARCHAR2(100),
    mem_detail_address   VARCHAR2(100),
    mem_gender   VARCHAR2(2),
    mem_birth_date DATE,
    mem_register_date DATE,
    mem_point   NUMBER(8),
    mem_status NUMBER(1) DEFAULT 0,
    mem_law1_check VARCHAR2(2),
    mem_law2_check VARCHAR2(2),
    mem_law3_check VARCHAR2(2),
    mem_law4_check VARCHAR2(2),
    mem_law5_check VARCHAR2(2),
    mem_sms_check VARCHAR2(2),
    mem_email_check VARCHAR2(2)
);

CREATE TABLE coupon (
	coupon_num	NUMBER(20)
    CONSTRAINT coupon_num_pk PRIMARY KEY,
    coupon_name VARCHAR2(100),
	mem_id	VARCHAR2(20)
    CONSTRAINT coupon_mem_fk REFERENCES members( mem_id ) ON DELETE CASCADE, 
	coupon_discount	NUMBER(3,2)
);

CREATE TABLE orders (
    order_num   NUMBER(20)
    CONSTRAINT order_num_pk PRIMARY KEY,
    order_id VARCHAR2(100),
    order_name   VARCHAR2(50),
    orderer_id VARCHAR2(20)
    CONSTRAINT order_mem_fk REFERENCES members(mem_id) ON DELETE CASCADE,
    orderer_name VARCHAR2(50),
    orderer_phone VARCHAR2(13),
    orderer_email VARCHAR2(50),
    receiver_name   VARCHAR2(50),
    receiver_zip_code   NUMBER(5),
    receiver_address   VARCHAR2(100),
    receiver_detail_address   VARCHAR2(100),
    receiver_phone   VARCHAR2(13),
    receiver_req   VARCHAR2(200),
    discount_coupon VARCHAR2(100),
    discount_points NUMBER(5),
    total_price NUMBER(8),
    total_discount NUMBER(8),
    pay_price NUMBER(8),
    pay_method VARCHAR2(30),
    order_status NUMBER(1),
    order_date   DATE
);

CREATE TABLE pay (
	pay_num	NUMBER(20)
    CONSTRAINT pay_num_pk PRIMARY KEY,
    pay_id VARCHAR2(50),
	order_num	NUMBER(20)
    CONSTRAINT pay_order_fk REFERENCES orders( order_num ) ON DELETE CASCADE,
	pay_price	NUMBER(8),
	pay_method	VARCHAR2(20), 
	pay_status	NUMBER(1),
    refund_req NUMBER(1),
	refund_status	NUMBER(1)
);

CREATE TABLE categories (
	category_num	NUMBER(20)
    CONSTRAINT category_num_pk PRIMARY KEY,
	category_name	VARCHAR2(100)	
);

CREATE TABLE products (
	product_num	NUMBER(20)
    CONSTRAINT product_num_pk PRIMARY KEY,
	category_num	NUMBER(20)
    CONSTRAINT product_category_fk REFERENCES categories( category_num ),
	product_name	VARCHAR2(100),
	product_price	NUMBER(8),
    product_info	VARCHAR2(4000),
    product_detail  VARCHAR2(4000),
    product_thumbnail_1	VARCHAR2(200),
    product_thumbnail_2	VARCHAR2(200),
    product_thumbnail_3	VARCHAR2(200),
    product_date DATE
); 

CREATE TABLE order_infos (
    order_info_num   NUMBER(20)
    CONSTRAINT order_info_num_pk PRIMARY KEY,
    order_num   NUMBER(20)
    CONSTRAINT info_order_fk REFERENCES orders( order_num ) ON DELETE CASCADE,
    product_num   NUMBER(20)
    CONSTRAINT info_product_fk REFERENCES products( product_num ) ON DELETE CASCADE,
    product_name VARCHAR2(30),
    order_info_qty   NUMBER(2),
    order_info_option VARCHAR2(1000),
    order_info_price NUMBER(8),
    ob_date   DATE
);

CREATE TABLE cart (
	cart_num	NUMBER(20)
    CONSTRAINT cart_num_pk PRIMARY KEY,
	product_num	NUMBER(20)
    CONSTRAINT cart_product_fk REFERENCES products ( product_num ) ON DELETE CASCADE,
	mem_id	VARCHAR2(20)
    CONSTRAINT cart_mem_fk REFERENCES members ( mem_id ) ON DELETE CASCADE,
	cart_product_qty	NUMBER(2),
    cart_product_price NUMBER(10),
    cart_product_option VARCHAR2(500)
);

CREATE TABLE wish_list (
	wish_num	NUMBER(20)
    CONSTRAINT wish_num_pk PRIMARY KEY,
	product_num	NUMBER(20)
    CONSTRAINT wish_product_fk REFERENCES products ( product_num ) ON DELETE CASCADE,
	mem_id	VARCHAR2(20)
    CONSTRAINT wish_mem_fk REFERENCES members ( mem_id ) ON DELETE CASCADE
);

CREATE TABLE qna (
	qna_num	NUMBER(20)
    CONSTRAINT qna_num_pk PRIMARY KEY,
	product_num	NUMBER(20)
    CONSTRAINT qna_product_fk REFERENCES products ( product_num ) ON DELETE CASCADE,
   	mem_id	VARCHAR2(20)
    CONSTRAINT qna_mem_fk REFERENCES members ( mem_id ) ON DELETE CASCADE,
	qna_title	VARCHAR2(100),
	qna_content	VARCHAR2(1000),
	qna_date	DATE,
	qna_category	VARCHAR2(100),
    qna_img_path VARCHAR2(200),
	qna_img_1	VARCHAR2(200),
    qna_img_2 VARCHAR2(200),
    qna_img_3 VARCHAR2(200),
    qna_status number(1)
);

CREATE TABLE qna_re (
	reply_num	NUMBER(20)
    CONSTRAINT reply_num_pk PRIMARY KEY,
	qna_num	NUMBER(20)
    CONSTRAINT reply_qna_fk REFERENCES qna ( qna_num ) ON DELETE CASCADE,
	reply_content	VARCHAR2(1000),
	reply_date	DATE
);

CREATE TABLE reviews (
	review_num	NUMBER(20)
    CONSTRAINT review_num_pk PRIMARY KEY,
	product_num	NUMBER(20)
    CONSTRAINT review_product_fk REFERENCES products ( product_num ) ON DELETE CASCADE,
	mem_id	VARCHAR2(20)
    CONSTRAINT review_mem_fk REFERENCES members ( mem_id ) ON DELETE CASCADE,
	review_content	VARCHAR2(1000),
	review_date	DATE,
	review_rating NUMBER(1),
    review_img_path VARCHAR2(200),
	review_img_1 VARCHAR2(200),
	review_img_2 VARCHAR2(200),
	review_img_3 VARCHAR2(200),
    review_good NUMBER(3),
    review_bad NUMBER(3)
);

CREATE TABLE comments (
   comment_num   NUMBER(20)
    CONSTRAINT comment_num_pk PRIMARY KEY,
   review_num   NUMBER(20)
    CONSTRAINT comment_review_fk REFERENCES reviews ( review_num ) ON DELETE CASCADE,
   comment_id   VARCHAR2(20),
   comment_content   VARCHAR2(400),
   comment_date   DATE
);

CREATE TABLE notice (
	notice_num	NUMBER(20)
    CONSTRAINT notice_num_pk PRIMARY KEY,
	notice_title	VARCHAR2(100),
	notice_content	VARCHAR2(4000),
	notice_date	DATE
);

CREATE SEQUENCE products_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE notice_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE order_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE order_info_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE qna_num_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE review_num_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE wish_num_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE cart_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE coupon_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE pay_seq INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE reply_num_seq INCREMENT BY 1 START WITH 1 NOCACHE;
