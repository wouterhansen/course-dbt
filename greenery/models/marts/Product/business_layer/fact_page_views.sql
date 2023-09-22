{{config(materialized = 'table')}}
with source as (
    select * from {{ ref('il_fact_page_views') }}
)
select * from source