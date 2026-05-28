WITH raw_payments AS (
  SELECT * FROM OLIST.RAW.raw_order_payments
)

SELECT
  order_id,
  payment_type,
  payment_installments,
  payment_value

FROM raw_payments