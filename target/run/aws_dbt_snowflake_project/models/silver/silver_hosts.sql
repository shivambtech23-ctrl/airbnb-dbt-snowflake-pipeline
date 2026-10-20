-- back compat for old kwarg name
  
  begin;
    
        
            
            
            
            
        
    

    

    merge into AIRBNB.silver.silver_hosts as DBT_INTERNAL_DEST
        using AIRBNB.silver.silver_hosts__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.host_id = DBT_INTERNAL_DEST.host_id))

    
    when matched then update set
        "HOST_ID" = DBT_INTERNAL_SOURCE."HOST_ID","HOST_NAME" = DBT_INTERNAL_SOURCE."HOST_NAME","HOST_SINCE" = DBT_INTERNAL_SOURCE."HOST_SINCE","IS_SUPERHOST" = DBT_INTERNAL_SOURCE."IS_SUPERHOST","RESPONSE_RATE" = DBT_INTERNAL_SOURCE."RESPONSE_RATE","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","_LOADED_AT" = DBT_INTERNAL_SOURCE."_LOADED_AT"
    

    when not matched then insert
        ("HOST_ID", "HOST_NAME", "HOST_SINCE", "IS_SUPERHOST", "RESPONSE_RATE", "CREATED_AT", "_LOADED_AT")
    values
        ("HOST_ID", "HOST_NAME", "HOST_SINCE", "IS_SUPERHOST", "RESPONSE_RATE", "CREATED_AT", "_LOADED_AT")

;
    commit;