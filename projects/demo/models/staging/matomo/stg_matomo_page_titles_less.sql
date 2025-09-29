WITH source AS (
      SELECT * FROM {{ source('matomo', 'page_titles') }}
),
renamed AS (
    select
        date,
        min_time_server,
        coalesce(exit_nb_uniq_visitors::float::int, 0) AS exit_nb_uniq_visitors,
        avg_page_load_time,
        sum_time_spent,
        bounce_rate,
        entry_nb_actions,
        coalesce(entry_nb_uniq_visitors::float::int, 0) AS entry_nb_uniq_visitors,
        avg_time_on_page,
        actions_pagetitle,
        segment,
        nb_visits,
        coalesce(entry_bounce_count::float::int, 0) as entry_bounce_count,
        coalesce(exit_nb_visits::float::int, 0) as exit_nb_visits,
        label,
        coalesce(entry_nb_visits::float::int, 0) as entry_nb_visits,
        entry_sum_visit_length,
        nb_hits,
        nb_uniq_visitors,
        exit_rate,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'avg_time_transfer', 'INTEGER') }}
    FROM source
)
select * FROM renamed
  