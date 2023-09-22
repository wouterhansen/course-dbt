{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_order_items') }}
)
select * from source