WITH source AS (
      SELECT * FROM {{ source('matomo', 'page_titles') }}
),
renamed AS (
    select
        date,
        min_time_server,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'min_time_dom_processing', 'INTEGER') }},
        coalesce(exit_nb_uniq_visitors::float::int, 0) AS exit_nb_uniq_visitors,
        avg_page_load_time,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'max_time_dom_processing', 'INTEGER') }},
        sum_time_spent,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'avg_time_dom_processing', 'INTEGER') }},
        bounce_rate,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'nb_hits_with_time_dom_processing', 'INTEGER') }},
        entry_nb_actions,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'max_time_transfer', 'INTEGER') }},
        coalesce(entry_nb_uniq_visitors::float::int, 0) AS entry_nb_uniq_visitors,
        avg_time_on_page,
        actions_pagetitle,
        segment,
        nb_visits,
        coalesce(entry_bounce_count::float::int, 0) as entry_bounce_count,
        coalesce(exit_nb_visits::float::int, 0) as exit_nb_visits,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'min_time_transfer', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'nb_hits_with_time_server', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'max_time_server', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'avg_time_server', 'INTEGER') }},
        label,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'nb_hits_with_time_transfer', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'avg_time_transfer', 'INTEGER') }},
        coalesce(entry_nb_visits::float::int, 0) as entry_nb_visits,
        entry_sum_visit_length,
        nb_hits,
        nb_uniq_visitors,
        exit_rate,
        avg_time_generation,
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'index', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'max_time_generation', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'min_time_generation', 'INTEGER') }},
        {{ get_column_if_exists(source('matomo', 'page_titles'), 'nb_hits_with_time_generation', 'INTEGER') }}
    FROM source
)
select * FROM renamed
  