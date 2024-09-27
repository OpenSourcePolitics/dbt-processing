SELECT 
    nb_visits,
    country_name,
    country,
    region_name,
    region,
    city_name,
    date, 
    lat, 
    long
FROM {{ ref ("stg_matomo_users_city")}} AS users_city