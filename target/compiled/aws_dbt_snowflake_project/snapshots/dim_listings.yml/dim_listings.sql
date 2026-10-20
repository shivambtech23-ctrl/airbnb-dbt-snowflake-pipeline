with __dbt__cte__listings as (


select 
    listing_id,
    property_type,
    room_type,
    city,
    country,
    price_tier,
    listing_created_at
from AIRBNB.gold.obt
) select * from __dbt__cte__listings