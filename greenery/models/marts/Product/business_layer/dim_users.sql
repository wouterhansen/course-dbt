{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_users') }}
)
select * from source