{{config(materialized = 'view')}}
with source as (
    select * from {{ ref('staging_promos') }}
)
select * from source