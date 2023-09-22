{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_fact_orders') }}
)
select * from source