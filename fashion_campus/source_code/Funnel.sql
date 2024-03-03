WITH funnel AS(
SELECT COUNT(CASE WHEN e1.event_name = 'ITEM_DETAIL' THEN e1.session_id ELSE NULL END) AS pageview_count,
       COUNT(CASE WHEN e1.event_name = 'ITEM_DETAIL' THEN e2.session_id ELSE NULL END) AS addtocart_5min_count,
       COUNT(CASE WHEN e1.event_name = 'ITEM_DETAIL' THEN e3.session_id ELSE NULL END) AS purchase_30min_count
FROM `fashion-campus-analysis.fashion_campus.click_stream` AS e1
LEFT JOIN `fashion-campus-analysis.fashion_campus.click_stream` AS e2 ON e1.session_id = e2.session_id
      AND e2.event_time BETWEEN e1.event_time AND TIMESTAMP_ADD(e1.event_time, INTERVAL 5 MINUTE)
      AND e2.event_name = 'ADD_TO_CART'
LEFT JOIN `fashion-campus-analysis.fashion_campus.click_stream` AS e3 ON e1.session_id = e3.session_id
      AND e3.event_time BETWEEN e1.event_time AND TIMESTAMP_ADD(e1.event_time, INTERVAL 30 MINUTE)
      AND e3.event_name = 'BOOKING'
WHERE EXTRACT(year FROM e1.event_time) = 2021
)

SELECT pageview_count,
       addtocart_5min_count,
       ROUND(addtocart_5min_count / pageview_count, 3) AS addtocart_5min_ratio,
       purchase_30min_count,
       ROUND(purchase_30min_count / pageview_count, 3) AS purchase_30min_ratio
FROM funnel