-- =======================================================================================
-- Description: SQL queries for click-through rate analysis and conversion funnels from landing pages to orders.
-- Author: Akhyar Thoriq Alfatah
-- =======================================================================================


-- CTE: Filter sessions based on landing pages and their progress through the funnel
WITH lander_1_website_sessions AS (
	SELECT 
		CASE WHEN pageview_url = '/lander-1' THEN wp.website_session_id ELSE NULL END AS website_session_id
	FROM website_pageviews as wp
	WHERE created_at BETWEEN '2012-06-19' AND '2012-07-28'
),
lander_1_pageview_level AS (
	SELECT
		l1ws.website_session_id,
		pageview_url,
		CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS product_page,
		CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
		CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS ordered_page
	FROM lander_1_website_sessions as l1ws
		LEFT JOIN website_pageviews as wp
			ON l1ws.website_session_id = wp.website_session_id
	WHERE pageview_url IN ('/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
),
lander_1_page_made AS (
	SELECT
		website_session_id,
		MAX(product_page) as product_made_it,
		MAX(mrfuzzy_page) as mrfuzzy_made_it,
		MAX(cart_page) as cart_made_it,
        MAX(shipping_page) as shipping_made_it,
        MAX(billing_page) as billing_made_it,
        MAX(ordered_page) as ordered_made_it
	FROM lander_1_pageview_level
	GROUP BY 1
),
home_website_sessions AS (
	SELECT 
		CASE WHEN pageview_url = '/home' THEN wp.website_session_id ELSE NULL END AS website_session_id
	FROM website_pageviews as wp
	WHERE created_at BETWEEN '2012-06-19' AND '2012-07-28'
),
home_pageview_level AS (
	SELECT
		hws.website_session_id,
		pageview_url,
		CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END AS product_page,
		CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
		CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END AS cart_page,
        CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END AS shipping_page,
        CASE WHEN pageview_url = '/billing' THEN 1 ELSE 0 END AS billing_page,
        CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END AS ordered_page
	FROM home_website_sessions as hws
		LEFT JOIN website_pageviews as wp
			ON hws.website_session_id = wp.website_session_id
	WHERE pageview_url IN ('/home', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
),
home_page_made AS (
	SELECT
		website_session_id,
		MAX(product_page) as product_made_it,
		MAX(mrfuzzy_page) as mrfuzzy_made_it,
		MAX(cart_page) as cart_made_it,
        MAX(shipping_page) as shipping_made_it,
        MAX(billing_page) as billing_made_it,
        MAX(ordered_page) as ordered_made_it
	FROM home_pageview_level
	GROUP BY 1
)
SELECT
	'/lader-1' AS landing_page,
	COUNT(website_session_id) as sessions,
    SUM(product_made_it) as to_product,
    SUM(mrfuzzy_made_it) as to_mrfuzzy,
    SUM(cart_made_it) as to_cart,
    SUM(shipping_made_it) as to_shipping,
    SUM(billing_made_it) as to_billing,
    SUM(ordered_made_it) as to_ordered,
    
    SUM(product_made_it)/COUNT(website_session_id) as product_click_rt,
    SUM(mrfuzzy_made_it)/SUM(product_made_it) as mrfuzzy_click_rt,
    SUM(cart_made_it)/SUM(mrfuzzy_made_it) as cart_click_rt,
    SUM(shipping_made_it)/SUM(cart_made_it) as shipping_click_rt,
    SUM(billing_made_it)/SUM(shipping_made_it) as billing_click_rt,
    SUM(ordered_made_it)/SUM(billing_made_it) as ordered_click_rt
FROM lander_1_page_made
UNION
SELECT
	'/home' AS landing_page,
	COUNT(website_session_id) as sessions,
    SUM(product_made_it) as to_product,
    SUM(mrfuzzy_made_it) as to_mrfuzzy,
    SUM(cart_made_it) as to_cart,
    SUM(shipping_made_it) as to_shipping,
    SUM(billing_made_it) as to_billing,
    SUM(ordered_made_it) as to_ordered,
    
    SUM(product_made_it)/COUNT(website_session_id) as product_click_rt,
    SUM(mrfuzzy_made_it)/SUM(product_made_it) as mrfuzzy_click_rt,
    SUM(cart_made_it)/SUM(mrfuzzy_made_it) as cart_click_rt,
    SUM(shipping_made_it)/SUM(cart_made_it) as shipping_click_rt,
    SUM(billing_made_it)/SUM(shipping_made_it) as billing_click_rt,
    SUM(ordered_made_it)/SUM(billing_made_it) as order_click_rt
FROM home_page_made;