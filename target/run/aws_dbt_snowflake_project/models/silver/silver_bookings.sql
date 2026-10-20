-- back compat for old kwarg name
  
  begin;
    
        
            
            
            
            
        
    

    

    merge into AIRBNB.silver.silver_bookings as DBT_INTERNAL_DEST
        using AIRBNB.silver.silver_bookings__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.booking_id = DBT_INTERNAL_DEST.booking_id))

    
    when matched then update set
        "BOOKING_ID" = DBT_INTERNAL_SOURCE."BOOKING_ID","LISTING_ID" = DBT_INTERNAL_SOURCE."LISTING_ID","BOOKING_DATE" = DBT_INTERNAL_SOURCE."BOOKING_DATE","TOTAL_AMOUNT" = DBT_INTERNAL_SOURCE."TOTAL_AMOUNT","BOOKING_STATUS" = DBT_INTERNAL_SOURCE."BOOKING_STATUS","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","_LOADED_AT" = DBT_INTERNAL_SOURCE."_LOADED_AT"
    

    when not matched then insert
        ("BOOKING_ID", "LISTING_ID", "BOOKING_DATE", "TOTAL_AMOUNT", "BOOKING_STATUS", "CREATED_AT", "_LOADED_AT")
    values
        ("BOOKING_ID", "LISTING_ID", "BOOKING_DATE", "TOTAL_AMOUNT", "BOOKING_STATUS", "CREATED_AT", "_LOADED_AT")

;
    commit;