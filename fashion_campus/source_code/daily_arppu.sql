SELECT FORMAT_TIMESTAMP('%Y-%m-%d', created_at) AS order_date,
       COUNT(DISTINCT customer_id) AS order_user,
       SUM(total_amount) AS order_amount,
       CAST(SUM(total_amount) / COUNT(DISTINCT customer_id) AS INTEGER) AS ARPPU
FROM `fashion-campus-analysis.fashion_campus.transaction`
WHERE EXTRACT(year FROM created_at) = 2021
GROUP BY order_date
ORDER BY order_date