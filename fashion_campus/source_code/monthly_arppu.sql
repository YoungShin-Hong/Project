SELECT FORMAT_TIMESTAMP('%Y-%m', created_at) AS order_month,
       COUNT(DISTINCT customer_id) AS order_user,
       SUM(total_amount) AS order_amount,
       CAST(SUM(total_amount) / COUNT(DISTINCT customer_id) AS INTEGER) AS ARPPU
FROM `fashion-campus-analysis.fashion_campus.transaction`
WHERE payment_status = 'Success' AND 
EXTRACT(year FROM created_at) = 2021
GROUP BY order_month
ORDER BY order_month