 WITH first_order AS(
  SELECT CAST(MIN(created_at) AS DATE) AS first_order_date,
  customer_id
  FROM `fashion-campus-analysis.fashion_campus.transaction`
  WHERE payment_status = 'Success'
  GROUP BY customer_id
 )

SELECT FORMAT_TIMESTAMP('%Y-%m', first_order_date) AS first_order_month,
COUNT(DISTINCT t.customer_id) AS month_0,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 1) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_1,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 2) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_2,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 3) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_3,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 4) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_4,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 5) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_5,
COUNT(DISTINCT CASE WHEN (EXTRACT(month FROM first_order_date) + 6) = EXTRACT(month FROM t.created_at) THEN t.customer_id END) AS month_6,
FROM `fashion-campus-analysis.fashion_campus.transaction` AS t
LEFT JOIN first_order AS f ON t.customer_id = f.customer_id
WHERE t.payment_status = 'Success' AND 
EXTRACT(year FROM first_order_date) = 2021
GROUP BY first_order_month
ORDER BY first_order_month