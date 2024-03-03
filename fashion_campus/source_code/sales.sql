WITH monthly_purchase AS(
  SELECT EXTRACT(year FROM created_at) AS year,
         EXTRACT(month FROM created_at) AS month,
         COUNT(DISTINCT booking_id) AS order_count,
         SUM(total_amount) AS order_amount,
         CAST(ROUND(AVG(total_amount)) AS INTEGER) AS avg_amount
  FROM `fashion-campus-analysis.fashion_campus.transaction`
  WHERE payment_status = 'Success'
  GROUP BY year, month
)

SELECT year,
       month,
       order_count,
       avg_amount,
       order_amount,
       SUM(order_amount) OVER(PARTITION BY year ORDER BY month ROWS UNBOUNDED PRECEDING) AS agg_amount,
       LAG(order_amount, 12) OVER (ORDER BY year, month) AS last_year,
       ROUND(order_amount / LAG(order_amount, 12) OVER (ORDER BY year, month) * 100, 1) AS YoY
FROM monthly_purchase
WHERE year >= 2020
ORDER BY year, month