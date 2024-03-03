WITH user_age AS (
  SELECT customer_id,
  (EXTRACT(year FROM CURRENT_DATETIME()) - EXTRACT(year FROM birthdate) + 1) AS age,
  gender
  FROM `fashion-campus-analysis.fashion_campus.customers`
)

SELECT CASE WHEN u.age >= 10 AND u.age < 20 THEN '10대'
            WHEN u.age >= 20 AND u.age < 30 THEN '20대'
            WHEN u.age >= 30 AND u.age < 40 THEN '30대'
            WHEN u.age >= 40 AND u.age < 50 THEN '40대'
            ELSE '50-'
        END AS age_band,
       COUNT(DISTINCT t.customer_id) AS order_count,
       ROUND((COUNT(DISTINCT t.customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM `fashion-campus-analysis.fashion_campus.transaction`)) * 100, 2) AS order_rate
FROM user_age AS u
LEFT JOIN `fashion-campus-analysis.fashion_campus.transaction` AS t ON u.customer_id = t.customer_id
WHERE payment_status = 'Success'
  AND EXTRACT(year FROM t.created_at) = 2021
GROUP BY age_band
ORDER BY age_band