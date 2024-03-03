WITH order_month_table AS(
  SELECT *,
				 FORMAT_TIMESTAMP('%Y-%m', created_at) AS order_month,
         MIN(created_at) OVER (PARTITION BY customer_id) AS first_order
  FROM `fashion-campus-analysis.fashion_campus.transaction`
  )

SELECT order_month,
       CASE WHEN created_at= first_order THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_new_order,
       COUNT(DISTINCT booking_id) AS order_count,
       CAST(AVG(total_amount) AS INTEGER) AS avg_order_amount
FROM order_month_table
WHERE EXTRACT(year FROM created_at) = 2021
GROUP BY order_month, is_new_order
ORDER BY order_month, is_new_order DESC