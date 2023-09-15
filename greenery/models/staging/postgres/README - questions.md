
* How many users do we have? —> 130 


select
    count ( distinct  user_id)
from DEV_DB.DBT_WOUTERHANSEN.STAGING_USERS
   


* On average, how many orders do we receive per hour? —> 7.5 


with x as (
    select
count(order_id) as orders,
date_part (hour, created_at), --there are 48 hours in this dateset, maybe different method with total year or so  
date_part (day, created_at) --there are 2 days 
--created_at

  -- *
from DEV_DB.DBT_WOUTERHANSEN.STAGING_ORDERS
group by 2,3 ) 
select avg (orders) from x

* On average, how long does an order take from being placed to being delivered? —> 93 hrs / 3.9 days

with x as (select 
order_id,
created_at, 
delivered_at,
datediff(hours, created_at,delivered_at) as hours,
datediff(days, created_at,delivered_at) as days

from DEV_DB.DBT_WOUTERHANSEN.STAGING_ORDERS
where delivered_at is not null ) 

select 
avg (hours) ,
avg (days)

from x 

  
* How many users have only made one purchase? Two purchases? Three+ purchases?
    * Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
1: 25
2: 28
3+: 71 

with x as (select 
user_id, 
count(order_id) as number_of_orders 
from DEV_DB.DBT_WOUTERHANSEN.STAGING_ORDERS 
group by 1 ) 

select 

-- sum (case when number_of_orders = 1 then 1 end )  one_order,
-- sum (case when number_of_orders = 2 then 1 end )  two_orders,
-- sum (case when number_of_orders > 2 then 1 end )  three_or_more_orders

case 
    when number_of_orders = 1 then 1
    when number_of_orders = 2 then 2
    else 3 end as number_of_orders, 
count(user_id)

from x 
 group by 1
 order by 1 


* On average, how many unique sessions do we have per hour? —> 16.3 


with x as (
select 
count(distinct session_id) as sessions,
left(created_at, 13)

from DEV_DB.DBT_WOUTERHANSEN.STAGING_EVENTS 
group by 2)

select avg (sessions) from x 