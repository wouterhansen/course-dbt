{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_events') }}
)
select * from source