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