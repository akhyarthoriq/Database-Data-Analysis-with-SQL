-- =======================================================================================
-- Description: SQL queries for analyzing landing page performance and revenue impact during a test period.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- CTE for sessions on lander-1 during the test period
WITH lander_1_pageviews AS (
	SELECT
        website_session_id, -- Identify sessions that visited lander-1
        COUNT(DISTINCT website_session_id) AS lander_1_sessions
    FROM website_pageviews
    WHERE pageview_url = '/lander-1' -- Focus only on lander-1
      AND created_at BETWEEN '2012-06-19' AND '2012-07-28'
    GROUP BY website_session_id
)
-- Main query to calculate metrics
SELECT
	MIN(DATE(ws.created_at)) as week_start_date,
    COUNT(DISTINCT l1pv.website_session_id) as sessions,
    COUNT(DISTINCT o.order_id) as orders,
    COUNT(DISTINCT o.order_id)/COUNT(DISTINCT l1pv.website_session_id) as conv_rate,  -- Conversion rate: Orders / Sessions
    -- If refund is counted
    -- SUM(o.price_usd)-SUM(CASE WHEN oir.refund_amount_usd IS NOT NULL AND oir.created_at BETWEEN '2012-06-19' AND '2012-07-28' THEN oir.refund_amount_usd ELSE 0 END) as estimate_revenue_usd
    SUM(o.price_usd) as estimate_revenue_usd
FROM lander_1_pageviews as l1pv
	LEFT JOIN website_sessions as ws
		ON l1pv.website_session_id = ws.website_session_id
	LEFT JOIN orders as o
		ON ws.website_session_id = o.website_session_id
-- 	LEFT JOIN order_item_refunds as oir						-- Join to refunds (optional)
-- 		ON o.order_id = oir.order_id
WHERE ws.created_at BETWEEN '2012-06-19' AND '2012-07-28'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(ws.created_at)
ORDER BY YEARWEEK(ws.created_at);