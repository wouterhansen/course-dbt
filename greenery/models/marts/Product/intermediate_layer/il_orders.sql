{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_orders') }}
)
select * from source