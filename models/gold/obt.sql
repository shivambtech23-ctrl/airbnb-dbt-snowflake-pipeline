{% set configs = [
    {
        "table": ref('silver_bookings'),
        "alias": "silver_bookings",
        "columns": "silver_bookings.booking_id, silver_bookings.listing_id, silver_bookings.booking_date, silver_bookings.total_amount, silver_bookings.booking_status, silver_bookings.created_at as booking_created_at"
    },
    {
        "table": ref('silver_listings'),
        "alias": "silver_listings",
        "columns": "silver_listings.host_id, silver_listings.property_type, silver_listings.room_type, silver_listings.city, silver_listings.country, silver_listings.accommodates, silver_listings.bedrooms, silver_listings.bathrooms, silver_listings.price_per_night as price_tier, silver_listings.created_at as listing_created_at",
        "join_condition": "silver_bookings.listing_id = silver_listings.listing_id"
    },
    {
        "table": ref('silver_hosts'),
        "alias": "silver_hosts",
        "columns": "silver_hosts.host_name, silver_hosts.host_since, silver_hosts.is_superhost, silver_hosts.response_rate as response_quality, silver_hosts.created_at as host_created_at",
        "join_condition": "silver_listings.host_id = silver_hosts.host_id"
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