{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_order_items') }}
)
select * from source