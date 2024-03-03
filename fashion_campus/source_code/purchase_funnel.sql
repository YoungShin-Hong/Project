WITH purchase_table AS(
  SELECT event_name,
         session_id,
  FROM `fashion-campus-analysis.fashion_campus.click_stream`
  WHERE event_name IN ('CLICK','ADD_TO_CART','BOOKING')
        AND EXTRACT(year FROM event_time) = 2021
  ),

purchase_funnel AS(
  SELECT event_name,
         COUNT(session_id) AS action_count,
         LAG(COUNT(session_id)) OVER(ORDER BY COUNT(session_id) DESC) AS prev_count
  FROM purchase_table
  GROUP BY event_name
  ORDER BY action_count DESC
)

SELECT event_name,
       action_count,
       CASE WHEN prev_count IS NULL THEN 100
            ELSE ROUND((action_count / prev_count) * 100, 2)
       END AS cvr_1,
       ROUND((action_count / FIRST_VALUE(action_count) OVER(ORDER BY action_count DESC)) * 100, 2) AS cvr_2
FROM purchase_funnel