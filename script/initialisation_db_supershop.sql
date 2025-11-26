CREATE DATABASE SuperShopAnalytics;



CREATE SCHEMA IF NOT EXISTS supershopanalytics; 

DROP TABLE IF EXISTS supershopanalytics.categories;
CREATE TABLE IF NOT EXISTS supershopanalytics.categories
(
    category_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(50) ,
    description character varying(50) ,
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
);

DROP TABLE IF EXISTS supershopanalytics.customers; 
CREATE TABLE IF NOT EXISTS supershopanalytics.customers
(
    customer_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    firstname character varying(255) ,
    lastname character varying(255) ,
	email character varying(255) ,
	created_at date NOT NULL  ,
	
    CONSTRAINT customer_pkey PRIMARY KEY (customer_id)
);

DROP TABLE IF EXISTS supershopanalytics.products; 
CREATE TABLE IF NOT EXISTS supershopanalytics.products
(
    product_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(255) ,
    price character varying(255) ,
	stock character varying(255) ,
	category_id integer NOT NULL  ,
	CONSTRAINT products_pkey PRIMARY KEY (product_id),
	CONSTRAINT fk_category_id FOREIGN KEY (category_id)
                        REFERENCES supershopanalytics.categories(category_id)
    
);

DROP TABLE IF EXISTS supershopanalytics.orders; 

CREATE TABLE IF NOT EXISTS supershopanalytics.orders
(
    order_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    order_date date ,
    statut_id integer NOT NULL ,
	customer_id integer NOT NULL  ,
	CONSTRAINT orders_pkey PRIMARY KEY (order_id),
	CONSTRAINT fk_customer_id FOREIGN KEY (customer_id)
                        REFERENCES supershopanalytics.customers(customer_id),
	CONSTRAINT fk_statut_id FOREIGN KEY (statut_id)
                        REFERENCES supershopanalytics.statut_commande(statut_id)
    
);

DROP TABLE IF EXISTS supershopanalytics.orders_items;
CREATE TABLE IF NOT EXISTS supershopanalytics.orders_items
(
    product_id integer NOT NULL ,
    order_id integer NOT NULL ,
    quantity integer ,
	price decimal    ,
	CONSTRAINT product_order_pkey PRIMARY KEY (product_id,order_id),
	CONSTRAINT fk_product_id FOREIGN KEY (product_id)
                        REFERENCES supershopanalytics.products(product_id),
	CONSTRAINT fk_order_id FOREIGN KEY (order_id)
                        REFERENCES supershopanalytics.orders(order_id)
    
);


DROP TABLE IF EXISTS supershopanalytics.statut_commande;
CREATE TABLE IF NOT EXISTS supershopanalytics.statut_commande
(
    statut_id integer NOT NULL ,
    status_name character varying(255) NOT NULL ,
	CONSTRAINT statut_id_pkey PRIMARY KEY (statut_id)
	 
);

ALTER TABLE supershopanalytics.statut_commande
    ALTER COLUMN statut_id
    ADD GENERATED ALWAYS AS IDENTITY;






