WITH user_action_date AS (
  SELECT t.customer_id,
         CAST(s.event_time AS DATE) AS action_date,
         CAST(LAG(s.event_time) OVER(PARTITION BY t.customer_id ORDER BY s.event_time) AS DATE) AS last_action_date
  FROM `fashion-campus-analysis.fashion_campus.click_stream` AS s
  LEFT JOIN `fashion-campus-analysis.fashion_campus.transaction` AS t ON s.session_id = t.session_id
  WHERE t.customer_id IS NOT NULL 
        AND EXTRACT(year FROM s.event_time) = 2021
  ORDER BY t.customer_id, action_date
),

user_join_action AS(
  SELECT c.customer_id,
         MAX(c.first_join_date) AS first_join_date,
         action_date,
         MAX(last_action_date) AS last_action_date
  FROM `fashion-campus-analysis.fashion_campus.customers` AS c
  LEFT JOIN user_action_date AS a ON c.customer_id = a.customer_id
  WHERE action_date IS NOT NULL
  GROUP BY customer_id, action_date
  ORDER BY c.customer_id, action_date
),

user_type AS(
  SELECT action_date,
         customer_id,
         CASE WHEN first_join_date = MAX(action_date) OVER(PARTITION BY customer_id ORDER BY action_date) THEN 'new'
              WHEN DATE_DIFF(MAX(action_date) OVER(PARTITION BY customer_id ORDER BY action_date), MAX(last_action_date) OVER(PARTITION BY customer_id ORDER BY last_action_date), DAY) >= 15 THEN 'comeback'
              ELSE 'repeat' END AS C
  FROM user_join_action
  ORDER BY customer_id, action_date
)


SELECT action_date,
       COUNT(DISTINCT customer_id) AS DAU,
       COUNT(DISTINCT CASE WHEN C = 'new' THEN customer_id END) AS new_user,
       COUNT(DISTINCT CASE WHEN C = 'repeat' THEN customer_id END) AS repeat_user,
       COUNT(DISTINCT CASE WHEN C = 'comeback' THEN customer_id END) AS comeback_user
FROM user_type
GROUP BY action_date
ORDER BY action_date