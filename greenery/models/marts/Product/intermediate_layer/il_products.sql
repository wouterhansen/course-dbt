{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_products') }}
)
select * from source