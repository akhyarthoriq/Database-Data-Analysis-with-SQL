-- =======================================================================================
-- Description: SQL queries for analyzing monthly trends in sessions, orders, and conversion rates.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- Analyze monthly trends for gsearch sessions and orders --
SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    IFNULL(COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT ws.website_session_id), 0), 0) AS conversion_rate -- Conversion rate: Orders/Sessions, avoids division by zero
FROM website_sessions AS ws
	LEFT JOIN orders AS o
		ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-11-27'
	AND ws.utm_source = 'gsearch'
GROUP BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at)
ORDER BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at);
    
-- Monthly trends for gsearch sessions and orders split by campaign --
SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,
    COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'nonbrand' THEN ws.website_session_id END) AS nonbrand_sessions, 
    COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'nonbrand' THEN o.order_id END) AS nonbrand_orders,              
    COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'brand' THEN ws.website_session_id END) AS brand_sessions,       
    COUNT(DISTINCT CASE WHEN ws.utm_campaign = 'brand' THEN o.order_id END) AS brand_orders                     
FROM website_sessions AS ws
LEFT JOIN orders AS o
    ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-11-27' -- Filter data before November 27, 2012
  AND ws.utm_source = 'gsearch'    -- Include only gsearch traffic
GROUP BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at)
ORDER BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at); -- Sort results by year and month