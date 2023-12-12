-- 로그인한 유저를 기준으로 주별 Active User 카운트
SELECT DATE_TRUNC('week', occurred_at) AS week,
		   COUNT(DISTINCT user_id) AS weekly_active_users
FROM tutorial.yammer_events
WHERE event_name = 'login'
GROUP BY week
ORDER BY week