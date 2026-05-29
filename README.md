# Olist Analytics Pipeline

## Overview

This project is an end-to-end data analytics pipeline built using **dbt, Snowflake, AWS S3, and Tableau**. It transforms raw Brazilian e-commerce data into structured, analytics-ready models and visualizes key business metrics through a dashboard.

The project demonstrates:

* Data engineering (ingestion + modeling)
* Analytics engineering (dbt transformations)
* Data quality validation
* Business-focused dashboarding

---

## Architecture

![Architecture Diagram](./Olist_Architecture_Diagram.png)

### Pipeline Flow

S3 → Snowflake (Raw) → dbt (Staging → Fact → Marts) → Tableau Dashboard

**Layers:**

* **Ingestion Layer**: Data stored in AWS S3 and loaded into Snowflake
* **Raw Layer**: Unprocessed tables (`raw_orders`, `raw_customers`, etc.)
* **Staging Layer**: Cleaned and standardized models
* **Fact Layer**: Central `fact_orders` table (one row per order)
* **Marts Layer**: Aggregated analytics tables
* **Visualization Layer**: Tableau dashboard

---

## Dashboard

![Dashboard](./dashboard.png)

🔗 **Dashboard Link**: *(Add your Tableau Public link here)*

### Key Metrics

* Total Revenue (BRL)
* Total Orders
* Average Order Value (AOV)

### Insights

* Consistent growth in orders and revenue over time
* Stable average order value (~150–180 BRL)
* Seasonal spikes in revenue (notably late 2017)

---

## Tech Stack

* **Data Warehouse**: Snowflake
* **Transformation Tool**: dbt
* **Storage**: AWS S3
* **Visualization**: Tableau
* **Language**: SQL + Jinja

---

## Project Structure

```text
olistdbt/
│
├── models/
│   ├── staging/
│   │   ├── src_orders.sql
│   │   ├── src_customers.sql
│   │   ├── src_order_items.sql
│   │   ├── src_order_payments.sql
│   │   ├── src_order_reviews.sql
│   │   └── sources.yml
│   │
│   ├── marts/
│   │   └── mart_daily_metrics.sql
│   │
│   └── schema.yml
│
├── macros/
│   └── safe_divide.sql
│
├── analyses/
│   └── order_insights.sql
│
├── snapshots/
│   └── snap_customers.sql
│
├── dbt_project.yml
├── packages.yml
└── README.md
```

---

## Data Modeling

### Fact Table: `fact_orders`

**Grain**: one row per order

Includes:

* Customer details
* Order timestamps
* Revenue (aggregated from payments)
* Item metrics
* Review score
* Delivery performance

---

### Mart: `mart_daily_metrics`

**Grain**: one row per day

Metrics:

* Total Orders
* Total Revenue
* Average Order Value (correctly weighted)
* Average Delivery Delay

---

## Data Quality

dbt tests implemented:

* `not_null` on critical columns
* `unique` on `order_id`

Ensures:

* correct grain
* no duplication
* reliable analytics

---

## Macros

### safe_divide

```sql
{% macro safe_divide(numerator, denominator) %}
    CASE 
        WHEN {{ denominator }} = 0 OR {{ denominator }} IS NULL THEN NULL
        ELSE {{ numerator }} / {{ denominator }}
    END
{% endmacro %}
```

---

## Data Ingestion (S3 → Snowflake)

Data is stored in AWS S3 and loaded into Snowflake raw tables.

### Example Flow:

1. Upload CSV files to S3
2. Create Snowflake stage
3. Copy data into raw tables

---

## Setup & Permissions

To run this project, ensure:

### 1. Snowflake Access

* Database: `OLIST`
* Schemas: `RAW`, `DEV`
* Role with:

  * SELECT, INSERT, CREATE privileges

---

### 2. dbt Profile (`~/.dbt/profiles.yml`)

```yaml
olist:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your_account>
      user: <your_user>
      password: <your_password>
      role: <your_role>
      database: OLIST
      warehouse: <your_warehouse>
      schema: DEV
```

---

### 3. Run Commands

```bash
dbt deps
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

## Key Learnings

* Handling **many-to-one joins** in fact tables
* Avoiding **duplicate records via aggregation**
* Building **incremental models in dbt**
* Importance of **correct aggregation levels**
* Designing **analytics-ready marts**
* Debugging real-world data issues

---

## Future Improvements

* Add delivery performance metrics (% delayed orders)
* Introduce customer segmentation
* Automate ingestion pipeline
* Expand marts for advanced analytics

---

## Author

Divjyot Singh Suri

---

## Final Note

This project demonstrates a complete data workflow from ingestion to insights, combining data engineering and analytics into a production-style pipeline.
