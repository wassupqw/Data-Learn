create schema if not exists module_2;

-- module_2.customer_dim
drop table if exists module_2.customer_dim cascade;

CREATE TABLE module_2.customer_dim
(
 customer_id   varchar(10) NOT NULL,
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_32 PRIMARY KEY ( customer_id )
);

-- module_2.geography_dim
drop table if exists module_2.geography_dim cascade;

CREATE TABLE module_2.geography_dim
(
 geo_id      serial NOT NULL,
 country     varchar(20) NOT NULL,
 city        varchar(25) NOT NULL,
 "state"       varchar(20) NOT NULL,
 region      varchar(7) NOT NULL,
 postal_code varchar(20) NOT NULL,
 person      varchar(17) NOT NULL,
 CONSTRAINT PK_26 PRIMARY KEY ( geo_id )
);

-- module_2.oder_date_dim
drop table if exists module_2.order_date_dim cascade;

CREATE TABLE module_2.order_date_dim
(
 order_date date NOT NULL,
 day        int NOT NULL,
 week       int NOT NULL,
 month      int NOT NULL,
 quarter    varchar(5) NOT NULL,
 year       int NOT NULL,
 CONSTRAINT PK_41 PRIMARY KEY ( order_date )
);


-- module_2.product_dim
drop table if exists module_2.product_dim cascade;

CREATE TABLE module_2.product_dim
(
 product_id   varchar(15) NOT NULL,
 category     varchar(50) NOT NULL,
 sub_category varchar(50) NOT NULL,
 product_name varchar(130) NOT NULL,
 segment      varchar(50) NOT NULL,
 CONSTRAINT PK_35 PRIMARY KEY ( product_id )
);

-- module_2.ship_date_dim
drop table if exists module_2.ship_date_dim cascade;

CREATE TABLE module_2.ship_date_dim
(
 ship_date date NOT NULL,
 day       int NOT NULL,
 week      int NOT NULL,
 month     int NOT NULL,
 quarter   varchar(5) NOT NULL,
 year      int NOT NULL,
 CONSTRAINT PK_450 PRIMARY KEY ( ship_date )
);

-- module_2.shipping_dim
drop table if exists module_2.shipping_dim cascade;

CREATE TABLE module_2.shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_22 PRIMARY KEY ( ship_id )
);

-- module_2.sales_fact
drop table if exists module_2.sales_fact cascade;

CREATE TABLE module_2.sales_fact
(
 row_id      int NOT NULL,
 quantity    int NOT NULL,
 ship_date   date NOT NULL,
 order_date  date NOT NULL,
 customer_id varchar(10) NOT NULL,
 product_id  varchar(15) NOT NULL,
 geo_id      serial NOT NULL,
 ship_id     serial NOT NULL,
 discount    numeric(4,2) NOT NULL,
 sales       numeric(9,4) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 order_id    varchar(14) NOT NULL,
 returned    varchar(5) NOT NULL,
 CONSTRAINT PK_73 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_107 FOREIGN KEY ( ship_date ) REFERENCES module_2.ship_date_dim ( ship_date ),
 CONSTRAINT FK_78 FOREIGN KEY ( ship_id ) REFERENCES module_2.shipping_dim ( ship_id ),
 CONSTRAINT FK_81 FOREIGN KEY ( geo_id ) REFERENCES module_2.geography_dim ( geo_id ),
 CONSTRAINT FK_84 FOREIGN KEY ( product_id ) REFERENCES module_2.product_dim ( product_id ),
 CONSTRAINT FK_87 FOREIGN KEY ( customer_id ) REFERENCES module_2.customer_dim ( customer_id ),
 CONSTRAINT FK_90 FOREIGN KEY ( order_date ) REFERENCES module_2.order_date_dim ( order_date )
);

CREATE INDEX FK_109 ON module_2.sales_fact
(
 ship_date
);

CREATE INDEX FK_80 ON module_2.sales_fact
(
 ship_id
);

CREATE INDEX FK_83 ON module_2.sales_fact
(
 geo_id
);

CREATE INDEX FK_86 ON module_2.sales_fact
(
 product_id
);

CREATE INDEX FK_89 ON module_2.sales_fact
(
 customer_id
);

CREATE INDEX FK_93 ON module_2.sales_fact
(
 order_date
);


