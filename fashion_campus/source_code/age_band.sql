WITH user_age AS (
  SELECT customer_id,
  (EXTRACT(year FROM CURRENT_DATETIME()) - EXTRACT(year FROM birthdate) + 1) AS age
  FROM `fashion-campus-analysis.fashion_campus.customers`
)

SELECT CASE WHEN u.age >= 10 AND u.age < 20 THEN '10대'
            WHEN u.age >= 20 AND u.age < 30 THEN '20대'
            WHEN u.age >= 30 AND u.age < 40 THEN '30대'
            WHEN u.age >= 40 AND u.age < 50 THEN '40대'
            ELSE '50-'
        END AS age_band,
        COUNT(DISTINCT u.customer_id) AS join_user,
        COUNT(DISTINCT t.customer_id) AS order_user,
        ROUND(COUNT(DISTINCT t.customer_id) / COUNT(DISTINCT u.customer_id), 2) AS order_ratio,
        CAST(SUM(t.total_amount) / COUNT(DISTINCT t.customer_id) AS INTEGER) AS avg_order_amount
FROM user_age AS u
LEFT JOIN `fashion-campus-analysis.fashion_campus.transaction` AS t ON u.customer_id = t.customer_id
WHERE u.age > 9
GROUP BY age_band
ORDER BY age_band