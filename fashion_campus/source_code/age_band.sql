WITH user_age AS (
  SELECT customer_id,
  (EXTRACT(year FROM CURRENT_DATETIME()) - EXTRACT(year FROM birthdate) + 1) AS age
  FROM `fashion-campus-analysis.fashion_campus.customers`
),
purchase_user AS(
  SELECT *
  FROM `fashion-campus-analysis.fashion_campus.transaction`
  WHERE payment_status = 'Success' 
    AND EXTRACT(year FROM created_at) = 2021
)

SELECT CASE WHEN u.age >= 10 AND u.age < 20 THEN '10대'
            WHEN u.age >= 20 AND u.age < 30 THEN '20대'
            WHEN u.age >= 30 AND u.age < 40 THEN '30대'
            WHEN u.age >= 40 AND u.age < 50 THEN '40대'
            ELSE '50-'
        END AS age_band,
        COUNT(DISTINCT u.customer_id) AS join_user,
        COUNT(DISTINCT p.customer_id) AS order_user,
        ROUND(COUNT(DISTINCT p.customer_id) / COUNT(DISTINCT u.customer_id), 3) AS order_ratio,
        CAST(SUM(p.total_amount) / COUNT(DISTINCT p.customer_id) AS INTEGER) AS avg_order_amount
FROM user_age AS u
LEFT JOIN purchase_user AS p ON u.customer_id = p.customer_id
GROUP BY age_band
ORDER BY age_band