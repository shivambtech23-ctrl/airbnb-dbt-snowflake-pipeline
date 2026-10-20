

select 
    booking_id,
    listing_id,
    booking_date,
    
    round(booking_amount * nights_booked,2)
 + cleaning_fee + service_fee as total_amount,
    booking_status,
    created_at,
    current_timestamp() as _loaded_at
from AIRBNB.bronze.bronze_bookings