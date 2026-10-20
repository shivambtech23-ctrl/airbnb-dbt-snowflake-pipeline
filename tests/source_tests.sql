{{ config(severity = 'warn') }}

select
    booking_id,
    booking_amount,
    cleaning_fee,
    service_fee
from {{ source('staging', 'bookings') }}
where booking_amount < 0
   or cleaning_fee < 0
   or service_fee < 0
