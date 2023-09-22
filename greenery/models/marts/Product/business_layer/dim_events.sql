{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_events') }}
)
select * from source