/*


select * from airbnb.staging.bookings


  where created_at > (select coalesce(max(created_at), '1900-01-01') from AIRBNB.bronze.bronze_bookings)

*/


select
    *,
    current_timestamp() as _loaded_at
from airbnb.staging.bookings


  where created_at > (select coalesce(max(created_at), '1900-01-01') from AIRBNB.bronze.bronze_bookings)
