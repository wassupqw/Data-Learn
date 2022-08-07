-- calendar_dim

CREATE TABLE calendar_dim
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 day        int4range NOT NULL,
 week_day   int4range NOT NULL,
 month      int4range NOT NULL,
 quarter    varchar(5) NOT NULL,
 year       int4range NOT NULL,
 CONSTRAINT PK_41 PRIMARY KEY ( order_date, ship_date )
);

-- customer_dim

CREATE TABLE customer_dim
(
 customer_id   serial NOT NULL,
 customer_name varchar(22) NOT NULL,
 CONSTRAINT PK_32 PRIMARY KEY ( customer_id )
);

-- geography_dim

CREATE TABLE geography_dim
(
 geo_id      serial NOT NULL,
 country     varchar(14) NOT NULL,
 city        varchar(17) NOT NULL,
 "state"       varchar(11) NOT NULL,
 region      varchar(7) NOT NULL,
 postal_code int4range NOT NULL,
 person      varchar(17) NOT NULL,
 CONSTRAINT PK_26 PRIMARY KEY ( geo_id )
);

-- product_dim

CREATE TABLE product_dim
(
 product_id   serial NOT NULL,
 category     varchar(15) NOT NULL,
 sub_category varchar(11) NOT NULL,
 product_name varchar(127) NOT NULL,
 segment      varchar(11) NOT NULL,
 CONSTRAINT PK_35 PRIMARY KEY ( product_id )
);

-- shipping_dim

CREATE TABLE shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(14) NOT NULL,
 CONSTRAINT PK_22 PRIMARY KEY ( ship_id )
);

-- sales_fact

CREATE TABLE sales_fact
(
 row_id      int4range NOT NULL,
 quantity    int4range NOT NULL,
 order_date  date NOT NULL,
 customer_id serial NOT NULL,
 ship_date   date NOT NULL,
 product_id  serial NOT NULL,
 geo_id      serial NOT NULL,
 ship_id     serial NOT NULL,
 discount    numeric(4,2) NOT NULL,
 sales       numeric(9,4) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 order_id    varchar(14) NOT NULL,
 returned    varchar(5) NOT NULL,
 CONSTRAINT PK_73 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_78 FOREIGN KEY ( ship_id ) REFERENCES shipping_dim ( ship_id ),
 CONSTRAINT FK_81 FOREIGN KEY ( geo_id ) REFERENCES geography_dim ( geo_id ),
 CONSTRAINT FK_84 FOREIGN KEY ( product_id ) REFERENCES product_dim ( product_id ),
 CONSTRAINT FK_87 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( customer_id ),
 CONSTRAINT FK_90 FOREIGN KEY ( order_date, ship_date ) REFERENCES calendar_dim ( order_date, ship_date )
);

CREATE INDEX FK_80 ON sales_fact
(
 ship_id
);

CREATE INDEX FK_83 ON sales_fact
(
 geo_id
);

CREATE INDEX FK_86 ON sales_fact
(
 product_id
);

CREATE INDEX FK_89 ON sales_fact
(
 customer_id
);

CREATE INDEX FK_93 ON sales_fact
(
 order_date,
 ship_date
);