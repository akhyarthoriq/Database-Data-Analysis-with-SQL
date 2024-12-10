-- =======================================================================================
-- Description: SQL queries for evaluating billing page performance and revenue per session.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================

-- Analyze billing page sessions and revenue
WITH billing_sessions AS (
    SELECT
        wp.website_session_id,
        CASE 
            WHEN wp.pageview_url = '/billing-2' THEN '/billing-2'
            WHEN wp.pageview_url = '/billing' THEN '/billing'
            ELSE NULL
        END AS billing_page,
        wp.created_at
    FROM website_pageviews AS wp
    WHERE wp.created_at BETWEEN '2012-09-10' AND '2012-11-10'
      AND wp.pageview_url IN ('/billing-2', '/billing')
),
billing_data AS (
    SELECT
        bs.billing_page,
        COUNT(DISTINCT bs.website_session_id) AS total_sessions,  -- Total billing sessions
        SUM(o.price_usd) AS total_revenue,                       -- Total revenue from orders
        -- Include refunds if needed
        SUM(o.price_usd) - SUM(CASE WHEN oir.refund_amount_usd IS NOT NULL THEN oir.refund_amount_usd ELSE 0 END) AS net_revenue,
        SUM(o.price_usd) / NULLIF(COUNT(DISTINCT bs.website_session_id), 0) AS revenue_per_session, -- Revenue per session
		COUNT(DISTINCT CASE WHEN bs.created_at BETWEEN '2012-10-10' AND '2012-11-10' THEN bs.website_session_id ELSE NULL END) AS recent_sessions
    FROM billing_sessions AS bs
    LEFT JOIN orders AS o
        ON bs.website_session_id = o.website_session_id
    LEFT JOIN order_item_refunds AS oir
        ON o.order_id = oir.order_id
    GROUP BY bs.billing_page
)
-- Final output combining test results with recent data
SELECT
    bd.billing_page,
    bd.total_sessions,
    bd.total_revenue,
    bd.net_revenue,
    bd.revenue_per_session,
    bd.recent_sessions,
    bd.recent_sessions * bd.revenue_per_session AS monthly_impact -- Estimated monthly impact
FROM billing_data AS bd
ORDER BY bd.billing_page;