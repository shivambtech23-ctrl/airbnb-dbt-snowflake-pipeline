{{
  config(
    materialized = 'incremental',
    unique_key = 'listing_id'
  )
}}

select
    listing_id,
    host_id,
    {{ trimmer('property_type') }} as property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    {{ tag('price_per_night') }} as price_per_night,
    created_at,
    current_timestamp() as _loaded_at
from {{ ref('bronze_listings') }}
