{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_orders') }}
), 

orders_analysis as (

select

order_id,
CREATED_AT, 
ESTIMATED_DELIVERY_AT,
DELIVERED_AT,
DATEDIFF(day ,CREATED_AT,ESTIMATED_DELIVERY_AT ) as EXPECTED_DELIVERY_TIME,
DATEDIFF(day ,CREATED_AT,DELIVERED_AT ) as ACTUAL_DELIVERY_TIME,
DATEDIFF(day ,CREATED_AT,DELIVERED_AT ) - DATEDIFF(day ,CREATED_AT,ESTIMATED_DELIVERY_AT ) as DELTA_DELIVERY, -- depending on location etc the estimate was created, incase the delta is 2+ days there is a risk of churn 
case when DATEDIFF(day ,CREATED_AT,ESTIMATED_DELIVERY_AT ) >= DATEDIFF(day ,CREATED_AT,DELIVERED_AT ) then 'No' else 'Yes' end as potential_churn_delivery


--from  DEV_DB.DBT_WOUTERHANSEN.STAGING_ORDERS 
from source
where status = 'delivered' and estimated_delivery_at is not null 
order by DELTA_DELIVERY desc

)

select
    s.order_id,
    s.user_id,
    s.promo_id,
    s.address_id,
    s.created_at,
    s.order_cost,
    s.shipping_cost,
    s.order_total,
    s.tracking_id,
    s.shipping_service,
    s.estimated_delivery_at,
    s.delivered_at,
    s.status,
    EXPECTED_DELIVERY_TIME,
    ACTUAL_DELIVERY_TIME,
    DELTA_DELIVERY, 
    potential_churn_delivery


from source as s
left join orders_analysis oa on s.order_id = oa.order_id






