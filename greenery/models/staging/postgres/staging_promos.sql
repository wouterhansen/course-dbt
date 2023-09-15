{{config(materialized = 'table')}}

with source as (
    select * from {{ source('postgres', 'promos') }}
), 

rename as (

SELECT
    promo_id, 
    discount, 
    status 
from source
) 

select * from rename 