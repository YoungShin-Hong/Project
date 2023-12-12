-- 주별 신규 가입 유저와 신규 활성 유저
SELECT DATE_TRUNC('week', created_at) AS week,
       COUNT(user_id) AS all_users,
       COUNT(activated_at) AS active_users 
FROM tutorial.yammer_users
WHERE created_at BETWEEN '2014-06-01 00:00:00' AND '2014-08-31 23:59:59'
GROUP BY week
ORDER BY week