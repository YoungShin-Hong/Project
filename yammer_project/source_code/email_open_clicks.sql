-- 이메일 오픈/ 클릭수
SELECT DATE_TRUNC('week', e1.occurred_at) AS week,
       COUNT(CASE WHEN e1.action = 'sent_weekly_digest' THEN e1.user_id ELSE NULL END) AS send_weekly_digest,
       COUNT(CASE WHEN e1.action = 'sent_weekly_digest' THEN e2.user_id ELSE NULL END) AS weekly_open,
       COUNT(CASE WHEN e1.action = 'sent_weekly_digest' THEN e3.user_id ELSE NULL END) AS weekly_ctr,
       COUNT(CASE WHEN e1.action = 'sent_reengagement_email' THEN e1.user_id ELSE NULL END) AS send_reengagement_email,
       COUNT(CASE WHEN e1.action = 'sent_reengagement_email' THEN e2.user_id ELSE NULL END) AS retain_open,
       COUNT(CASE WHEN e1.action = 'sent_reengagement_email' THEN e3.user_id ELSE NULL END) AS retain_ctr
FROM tutorial.yammer_emails e1
LEFT JOIN tutorial.yammer_emails e2 ON e1.user_id = e2.user_id
      AND e2.occurred_at BETWEEN e1.occurred_at AND e1.occurred_at + INTERVAL '5 MINUTE'
      AND e2.action = 'email_open'
LEFT JOIN tutorial.yammer_emails e3 ON e1.user_id = e3.user_id
      AND e3.occurred_at BETWEEN e1.occurred_at AND e1.occurred_at + INTERVAL '5 MINUTE'
      AND e3.action = 'email_clickthrough'
WHERE e1.occurred_at BETWEEN '2014-06-01 00:00:00' AND '2014-08-31 23:59:59' 
  AND e1.action IN ('sent_weekly_digest', 'sent_reengagement_email')
GROUP BY week