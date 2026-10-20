

select 
    
        silver_bookings.booking_id, silver_bookings.listing_id, silver_bookings.booking_date, silver_bookings.total_amount, silver_bookings.booking_status, silver_bookings.created_at as booking_created_at,
    
        silver_listings.host_id, silver_listings.property_type, silver_listings.room_type, silver_listings.city, silver_listings.country, silver_listings.accommodates, silver_listings.bedrooms, silver_listings.bathrooms, silver_listings.price_per_night as price_tier, silver_listings.created_at as listing_created_at,
    
        silver_hosts.host_name, silver_hosts.host_since, silver_hosts.is_superhost, silver_hosts.response_rate as response_quality, silver_hosts.created_at as host_created_at
    
from 
    
        
            AIRBNB.silver.silver_bookings as silver_bookings
        
    
        
            left join AIRBNB.silver.silver_listings as silver_listings
                on silver_bookings.listing_id = silver_listings.listing_id
        
    
        
            left join AIRBNB.silver.silver_hosts as silver_hosts
                on silver_listings.host_id = silver_hosts.host_id
        
    