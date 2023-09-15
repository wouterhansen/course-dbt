{{config(materialized='table')}}

with source as (
    select * from {{ source('postgres', 'addresses') }}
), 

rename as (

SELECT
    address_id,
    address,
    zipcode,
    state,
    country
from source
) 

select * from rename 