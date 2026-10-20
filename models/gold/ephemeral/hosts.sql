{{
  config(
    materialized = 'ephemeral'
  )
}}

select
    host_id,
    host_name,
    host_since,
    is_superhost,
    response_quality,
    host_created_at
from {{ ref('obt') }}
