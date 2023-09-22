{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_addresses') }}
)
select * from source