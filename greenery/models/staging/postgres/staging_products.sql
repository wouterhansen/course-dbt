{{config(materialized = 'table')}}

with source as (
    select * from {{ source('postgres', 'products') }}
), 

rename as (

SELECT
    product_id, 
    name, 
    price, 
    inventory 
from source
) 

select * from rename 