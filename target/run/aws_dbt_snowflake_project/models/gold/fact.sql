
  
    

create or replace transient table AIRBNB.gold.fact
    
    
    
    
    

    as (

select 
    
        obt.booking_id, obt.host_id, obt.listing_id, obt.total_amount, obt.accommodates, obt.bedrooms, obt.bathrooms,
    
        bronze_bookings.nights_booked, bronze_bookings.booking_amount, bronze_bookings.cleaning_fee, bronze_bookings.service_fee
    
from 
    
        
            AIRBNB.gold.obt as obt
        
    
        
            left join AIRBNB.bronze.bronze_bookings as bronze_bookings
                on obt.booking_id = bronze_bookings.booking_id
        
    
    )
;


  