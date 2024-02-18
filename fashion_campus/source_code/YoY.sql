WITH amount_table AS (
  SELECT FORMAT_TIMESTAMP('%Y-%m-%d', created_at) AS day,
         EXTRACT(year FROM created_at) AS year,
         EXTRACT(month FROM created_at) AS month,
         SUM(total_amount) AS total_amount
FROM `fashion-campus-analysis.fashion_campus.transaction`
GROUP BY day, year, month
ORDER BY day
)

SELECT month,
       SUM(CASE WHEN year = 2020 THEN total_amount END) AS `2020`,
       SUM(CASE WHEN year = 2021 THEN total_amount END) AS `2021`,
       (ROUND(CAST(SUM(CASE WHEN year = 2021 THEN total_amount END) / SUM(CASE WHEN year = 2020 THEN total_amount END) AS NUMERIC), 3) * 100.0) AS `YoY1`,
       SUM(CASE WHEN year = 2022 THEN total_amount END) AS `2022`,
       (ROUND(CAST(SUM(CASE WHEN year = 2022 THEN total_amount END) / SUM(CASE WHEN year = 2021 THEN total_amount END) AS NUMERIC), 3) * 100.0) AS `YoY2`
FROM amount_table
GROUP BY month
ORDER BY month