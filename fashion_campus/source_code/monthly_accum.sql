WITH order_month_table AS(
  SELECT FORMAT_TIMESTAMP('%Y-%m', created_at) AS order_month,
				 COUNT(DISTINCT booking_id) AS order_count,
				 SUM(total_amount) AS order_amount,
  FROM `fashion-campus-analysis.fashion_campus.transaction`
	WHERE EXTRACT(year FROM created_at) = 2021
  GROUP BY order_month
  ORDER BY order_month
)

SELECT order_month,
       order_count,
       order_amount,
       SUM(order_count) OVER (ORDER BY order_month) AS agg_order_count,
       SUM(order_amount) OVER (ORDER BY order_month) AS agg_order_amount
FROM order_month_table 