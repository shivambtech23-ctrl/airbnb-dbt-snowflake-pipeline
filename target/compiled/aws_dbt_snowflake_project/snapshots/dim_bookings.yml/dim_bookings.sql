with __dbt__cte__bookings as (


select
    booking_id,
    booking_date,
    booking_status,
    booking_created_at
from AIRBNB.gold.obt
) select * from __dbt__cte__bookings