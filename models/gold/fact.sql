{% set configs = [
    {
        "table": ref('obt'),
        "alias": "obt",
        "columns": "obt.booking_id, obt.host_id, obt.listing_id, obt.total_amount, obt.accommodates, obt.bedrooms, obt.bathrooms"
    },
    {
        "table": ref('bronze_bookings'),
        "alias": "bronze_bookings",
        "columns": "bronze_bookings.nights_booked, bronze_bookings.booking_amount, bronze_bookings.cleaning_fee, bronze_bookings.service_fee",
        "join_condition": "obt.booking_id = bronze_bookings.booking_id"
    }
] %}

select 
    {% for config in configs %}
        {{ config.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
from 
    {% for config in configs %}
        {% if loop.first %}
            {{ config.table }} as {{ config.alias }}
        {% else %}
            left join {{ config.table }} as {{ config.alias }}
                on {{ config.join_condition }}
        {% endif %}
    {% endfor %}
