CREATE STAGE oliststage
URL = 's3://olist-raw-databucket'
CREDENTIALS=(AWS_KEY_ID='YOUR_AWS_KEY' AWS_SECRET_KEY='YOUR_AWS_KEY')

CREATE OR REPLACE TABLE raw_customers(
customer_id STRING,
customer_unique_id STRING,
customer_zip_code_prefix INTEGER,
customer_city STRING,
customer_state STRING
);

COPY INTO raw_customers
FROM '@oliststage/olist_customers_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_orders(
order_id STRING,
customer_id	STRING, 
order_status STRING,
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,	
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);

COPY INTO raw_orders
FROM '@oliststage/olist_orders_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_order_items(
order_id STRING, 
order_item_id INT,
product_id STRING,
seller_id STRING,
shipping_limit_date TIMESTAMP,
price FLOAT,
freight_value FLOAT
);

COPY INTO raw_order_items
FROM '@oliststage/olist_order_items_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_order_payments(
order_id STRING,
payment_sequential INT,
payment_type STRING,
payment_installments INT,
payment_value FLOAT
);

COPY INTO raw_order_payments
FROM '@oliststage/olist_order_payments_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_order_reviews(
review_id STRING,
order_id STRING,
review_score INT,
review_comment_title STRING,
review_comment_message STRING,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP
);

COPY INTO raw_order_reviews
FROM '@oliststage/olist_order_reviews_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_products(
product_id	STRING,
product_category_name STRING,
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g FLOAT,
product_length_cm FLOAT,
product_height_cm FLOAT,	
product_width_cm FLOAT
);

COPY INTO raw_products
FROM '@oliststage/olist_products_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');


CREATE OR REPLACE TABLE raw_sellers(
seller_id STRING,
seller_zip_code_prefix INT,
seller_city	STRING,
seller_state STRING
);

COPY INTO raw_sellers
FROM '@oliststage/olist_sellers_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_geolocation(
geolocation_zip_code_prefix INT,
geolocation_lat	FLOAT, 
geolocation_lng	FLOAT, 
geolocation_city STRING,
geolocation_state STRING
);

COPY INTO raw_geolocation
FROM '@oliststage/olist_geolocation_dataset.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_product_category(
product_category_name STRING,
product_category_name_english STRING
);

COPY INTO raw_product_category
FROM '@oliststage/product_category_name_translation.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');
