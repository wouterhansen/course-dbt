{{config(materialized = 'view')}}

with source as (
    select * from {{ ref('staging_users') }}
), 


user_kpi as 

(with x as 

(select user_id, count(order_id) as number_of_orders 

from {{ ref( 'staging_orders') }}
--DEV_DB.DBT_WOUTERHANSEN.STAGING_ORDERS 

group by 1 )

select
    user_id,
    case 
        when number_of_orders = 0 then 0 
        when number_of_orders = 1 then 1 
        else 2 end as number_of_orders, 
        
    count(user_id) 

from x group by 1,2 )

select 
    r.user_id,
    r.first_name,
    r.last_name,
    r.email,
    r.phone_number,
    r.created_at,
    r.updated_at,
    r.address_id,
    u.number_of_orders, -- the higher the number the 'better' the consumer 
    case when u.number_of_orders = 2 then 1 else 0 end as repeat_rate -- take average to calc repeat rate (avg(repeat_rate) = 0.76 = 76%)

from source as r
left join user_kpi as u on r.user_id = u.user_id


