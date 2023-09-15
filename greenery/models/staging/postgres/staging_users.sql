{{config(materialized = 'table')}}

with source as (
    select * from {{ source('postgres', 'users') }}
), 

rename as (

SELECT
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
from source
) 

select * from rename 