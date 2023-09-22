{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_addresses') }}
)
select * from source