SELECT FORMAT_TIMESTAMP('%Y-%m', c.event_time) AS month,
       COUNT(DISTINCT t.customer_id) AS MAU
FROM `fashion-campus-analysis.fashion_campus.click_stream` AS c
LEFT JOIN `fashion-campus-analysis.fashion_campus.transaction` AS t ON c.session_id = t.session_id
WHERE EXTRACT(year FROM c.event_time) = 2022
GROUP BY month
ORDER BY month