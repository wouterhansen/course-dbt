SELECT 

	created_date
	, SUM(is_page_view) 								  AS page_view_count
	, SUM(is_add_to_cart) 								  AS add_to_cart_count
	, SUM(is_checkout) 									  AS checkout_count
	, SUM(is_add_to_cart) / NULLIFZERO(sum(is_page_view)) AS page_view_to_add_cart_rate
	, SUM(is_checkout) / NULLIFZERO(sum(is_add_to_cart))  AS add_to_cart_to_checkout_rate

FROM {{ ref ('fact_product_user_events') }}
GROUP BY created_date