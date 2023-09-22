{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_promos') }}
)
select * from source