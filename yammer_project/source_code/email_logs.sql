-- 이메일 관련 로그 카운트
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(DISTINCT CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_emails,
       COUNT(DISTINCT CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) AS reengagement_emails,
       COUNT(DISTINCT CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS emaiL_opens,
       COUNT(DISTINCT CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthroughs
FROM tutorial.yammer_emails
GROUP BY week
ORDER BY week