-- =======================================================================================
-- Description: SQL queries for analyzing campaign performance by utm_content, including conversion rates.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================

-- Analyze traffic by utm_content
SELECT
    ws.utm_content,                                         
    COUNT(DISTINCT ws.website_session_id) AS sessions,      
    COUNT(DISTINCT o.order_id) AS orders,                
    IFNULL(COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT ws.website_session_id), 0), 0) AS utm_content_cvr
    -- Conversion rate: Orders / Sessions, handles division by zero
FROM website_sessions AS ws
LEFT JOIN orders AS o
    ON ws.website_session_id = o.website_session_id        
WHERE ws.created_at BETWEEN '2014-01-01' AND '2014-02-01' 
GROUP BY ws.utm_content                                  
ORDER BY utm_content_cvr DESC; 