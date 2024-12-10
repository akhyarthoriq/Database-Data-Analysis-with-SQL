-- =======================================================================================
-- Description: SQL queries for splitting and analyzing traffic by campaigns (e.g., brand vs. nonbrand).
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- Monthly trends for gsearch and other channels split by device type --
SELECT DISTINCT device_type FROM website_sessions;

SELECT
    YEAR(ws.created_at) as year,
    MONTH(ws.created_at) as month,
    COUNT(DISTINCT CASE WHEN device_type='desktop' THEN ws.website_session_id ELSE NULL END) as desktop_sessions,
    COUNT(DISTINCT CASE WHEN device_type='desktop' THEN o.order_id ELSE NULL END) as desktop_orders,
    COUNT(DISTINCT CASE WHEN device_type='mobile' THEN ws.website_session_id ELSE NULL END) as mobile_sessions,
    COUNT(DISTINCT CASE WHEN device_type='mobile' THEN o.order_id ELSE NULL END) as mobile_orders
FROM website_sessions as ws
	LEFT JOIN orders as o
		ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-11-27'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1,2;