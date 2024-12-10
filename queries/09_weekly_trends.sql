-- =======================================================================================
-- Description: SQL queries for weekly trends analysis, focusing on sessions from Bsearch and Gsearch.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================

-- Weekly trends for bsearch and gsearch sessions
SELECT
	MIN(DATE(created_at)) as week_start_date,
    COUNT(DISTINCT CASE WHEN utm_source='bsearch' THEN website_session_id END) as bsearch_session,
    COUNT(DISTINCT CASE WHEN utm_source='gsearch' AND utm_campaign='nonbrand' THEN website_session_id END) as gsearch_nonbrand_session
FROM website_sessions
WHERE created_at BETWEEN '2012-08-22' AND '2012-11-29'
GROUP BY YEARWEEK(created_at);