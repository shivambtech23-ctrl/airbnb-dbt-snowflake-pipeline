
      
  
    

create or replace transient table airbnb.gold.dim_hosts
    
    
    
    
    

    as (
    

    select *,
        md5(coalesce(cast(host_id as varchar ), '')
         || '|' || coalesce(cast(host_created_at as varchar ), '')
        ) as dbt_scd_id,
        host_created_at as dbt_updated_at,
        host_created_at as dbt_valid_from,
        
  
  coalesce(nullif(host_created_at, host_created_at), to_date('9999-12-31'))
  as dbt_valid_to
from (
        with __dbt__cte__hosts as (


select
    host_id,
    host_name,
    host_since,
    is_superhost,
    response_quality,
    host_created_at
from AIRBNB.gold.obt
) select * from __dbt__cte__hosts
    ) sbq



    )
;


  
  