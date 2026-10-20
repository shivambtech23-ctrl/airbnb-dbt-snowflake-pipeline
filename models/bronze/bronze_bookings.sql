/*
{% set incremental_flag = 1 %}

select * from {{ source('staging', 'bookings') }}

{% if incremental_flag == 1 %}
  where created_at > (select coalesce(max(created_at), '1900-01-01') from {{ this }})
{% endif %}
*/
{{
  config(
    materialized = 'incremental'
  )
}}

select
    *,
    current_timestamp() as _loaded_at
from {{ source('staging', 'bookings') }}

{% if is_incremental() %}
  where created_at > (select coalesce(max(created_at), '1900-01-01') from {{ this }})
{% endif %}
