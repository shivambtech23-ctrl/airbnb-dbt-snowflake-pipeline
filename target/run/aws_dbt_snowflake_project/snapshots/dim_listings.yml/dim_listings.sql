
      
  
    

create or replace transient table airbnb.gold.dim_listings
    
    
    
    
    

    as (
    

    select *,
        md5(coalesce(cast(listing_id as varchar ), '')
         || '|' || coalesce(cast(listing_created_at as varchar ), '')
        ) as dbt_scd_id,
        listing_created_at as dbt_updated_at,
        listing_created_at as dbt_valid_from,
        
  
  coalesce(nullif(listing_created_at, listing_created_at), to_date('9999-12-31'))
  as dbt_valid_to
from (
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
    ) sbq



    )
;


  
  