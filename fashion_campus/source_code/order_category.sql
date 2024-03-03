WITH order_products AS(
  SELECT p.subCategory AS category,
         t.booking_id AS booking_id
  FROM `fashion-campus-analysis.fashion_campus.transaction` AS t
  LEFT JOIN `fashion-campus-analysis.fashion_campus.products` AS p ON t.product_id = p.id
  WHERE payment_status = 'Success' AND 
  EXTRACT(year FROM t.created_at) = 2021
)


SELECT category,
       COUNT(booking_id) AS order_count,
       ROUND((COUNT(booking_id) / (SELECT COUNT(*) FROM order_products)) * 100, 3) AS order_rate
FROM order_products
GROUP BY category
ORDER BY order_rate DESC