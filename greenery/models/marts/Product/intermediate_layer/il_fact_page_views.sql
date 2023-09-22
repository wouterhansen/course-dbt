
{{config(materialized = 'view')}}

with prd as (
    select * from {{ ref('staging_products') }}
), 

eve as (
        select * from {{ ref('staging_events') }}
)




select 
cast(created_at as date) as datum,
name as naming,
prd.product_id as product_id,
count(session_id) as total_sessions,
count(user_id) as total_users

FROM  prd as PRD 
LEFT JOIN eve as EVE 
ON PRD.PRODUCT_ID = EVE.PRODUCT_ID
group by 1,2,3
order by 2

