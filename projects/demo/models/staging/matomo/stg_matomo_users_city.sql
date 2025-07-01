WITH source AS (
      SELECT * FROM {{ source('matomo', 'users_city') }}
),
renamed AS (
    SELECT
        date,
        country,
        nb_actions,
        bounce_count,
        label,
        long,
        sum_visit_length,
        city_name,
        nb_visits_converted,
        max_actions,
        segment,
        nb_visits,
        country_name,
        logo,
        region_name,
        nb_uniq_visitors,
        nb_users,
        region,
        lat
    FROM source
)
SELECT * FROM renamed
  