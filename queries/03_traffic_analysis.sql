-- =======================================================================================
-- Description: SQL queries for analyzing traffic sources (e.g., Gsearch, Bsearch, Organic) and their performance.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- Monthly trends for Gsearch, Bsearch, Organic, and Direct traffic --
SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,

    -- Gsearch Metrics
    COUNT(DISTINCT CASE WHEN ws.utm_source = 'gsearch' THEN ws.website_session_id END) AS gsearch_sessions,
    COUNT(DISTINCT CASE WHEN ws.utm_source = 'gsearch' THEN o.order_id END) AS gsearch_orders,
    IFNULL(COUNT(DISTINCT CASE WHEN ws.utm_source = 'gsearch' THEN o.order_id END) / 
           NULLIF(COUNT(DISTINCT CASE WHEN ws.utm_source = 'gsearch' THEN ws.website_session_id END), 0), 0) AS gsearch_cvr,

    -- Bsearch Metrics
    COUNT(DISTINCT CASE WHEN ws.utm_source = 'bsearch' THEN ws.website_session_id END) AS bsearch_sessions,
    COUNT(DISTINCT CASE WHEN ws.utm_source = 'bsearch' THEN o.order_id END) AS bsearch_orders,
    IFNULL(COUNT(DISTINCT CASE WHEN ws.utm_source = 'bsearch' THEN o.order_id END) / 
           NULLIF(COUNT(DISTINCT CASE WHEN ws.utm_source = 'bsearch' THEN ws.website_session_id END), 0), 0) AS bsearch_cvr,

    -- Organic Search Metrics
    COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NOT NULL THEN ws.website_session_id END) AS organic_sessions,
    COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NOT NULL THEN o.order_id END) AS organic_orders,
    IFNULL(COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NOT NULL THEN o.order_id END) / 
           NULLIF(COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NOT NULL THEN ws.website_session_id END), 0), 0) AS organic_cvr,

    -- Direct Traffic Metrics
    COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NULL THEN ws.website_session_id END) AS direct_sessions,
    COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NULL THEN o.order_id END) AS direct_orders,
    IFNULL(COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NULL THEN o.order_id END) / 
           NULLIF(COUNT(DISTINCT CASE WHEN ws.utm_source IS NULL AND ws.http_referer IS NULL THEN ws.website_session_id END), 0), 0) AS direct_cvr

FROM website_sessions AS ws
LEFT JOIN orders AS o
    ON ws.website_session_id = o.website_session_id

WHERE ws.created_at < '2012-11-27' -- Filter for dates before November 27, 2012
GROUP BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at)
ORDER BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at);