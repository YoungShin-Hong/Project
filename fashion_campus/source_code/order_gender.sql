WITH user_age AS (
  SELECT customer_id,
  (EXTRACT(year FROM CURRENT_DATETIME()) - EXTRACT(year FROM birthdate) + 1) AS age,
  gender
  FROM `fashion-campus-analysis.fashion_campus.customers`
)

SELECT gender,
       COUNT(DISTINCT t.customer_id) AS order_count,
       ROUND((COUNT(DISTINCT t.customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM `fashion-campus-analysis.fashion_campus.transaction`)) * 100, 2) AS order_rate
FROM user_age AS u
LEFT JOIN `fashion-campus-analysis.fashion_campus.transaction` AS t ON u.customer_id = t.customer_id
WHERE payment_status = 'Success' 
  AND EXTRACT(year FROM t.created_at) = 2021
GROUP BY gender