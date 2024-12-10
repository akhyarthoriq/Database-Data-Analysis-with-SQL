-- =======================================================================================
-- Description: SQL queries for analyzing session-to-order conversion rates across various timeframes.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- Monthly session-to-order conversion rate --
SELECT
    YEAR(ws.created_at) AS year,                                      
    MONTH(ws.created_at) AS month,                                    
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,        
    COUNT(DISTINCT o.order_id) AS total_orders,                       
    IFNULL(COUNT(DISTINCT o.order_id) / NULLIF(COUNT(DISTINCT ws.website_session_id), 0), 0) AS conversion_rate -- Conversion rate: Total orders divided by total sessions, avoiding division by zero
FROM website_sessions AS ws
LEFT JOIN orders AS o
    ON ws.website_session_id = o.website_session_id                  
WHERE ws.created_at < '2012-11-27'                                  
GROUP BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at)                                            
ORDER BY 
    YEAR(ws.created_at), 
    MONTH(ws.created_at);  