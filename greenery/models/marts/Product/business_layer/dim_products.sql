{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_products') }}
)
select * from source