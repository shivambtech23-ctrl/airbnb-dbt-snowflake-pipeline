

select
    listing_id,
    host_id,
    
    upper(trim(property_type))
 as property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    
    case 
        when price_per_night < 100 then 'low'
        when price_per_night < 200 then 'medium'
        else 'high'
    end
 as price_per_night,
    created_at,
    current_timestamp() as _loaded_at
from AIRBNB.bronze.bronze_listings