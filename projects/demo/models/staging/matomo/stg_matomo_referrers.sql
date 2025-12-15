WITH result AS(
SELECT
    label,
    nb_uniq_visitors,
    nb_visits,
    nb_actions,
    sum_visit_length,
    bounce_count,
    {{ get_column_if_exists(source('matomo', 'referrers'), 'sub_type', 'TEXT') }},
    date
FROM {{ source('matomo', 'referrers') }}
)
SELECT * FROM result
WHERE sub_type IS NOT NULL