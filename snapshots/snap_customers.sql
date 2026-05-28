{% snapshot snap_customers %}

{{
  config(
    target_schema='snapshots',
    unique_key='customer_unique_id',
    strategy='check',
    check_cols=['customer_city', 'customer_state']
  )
}}

SELECT
  customer_unique_id,
  customer_city,
  customer_state
FROM {{ ref('src_customers') }}

{% endsnapshot %}