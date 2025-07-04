WITH source AS (
      SELECT * FROM {{ source('matomo', 'page_titles') }}
),
renamed AS (
    select
        date,
        min_time_server,
        min_time_dom_processing,
        coalesce(exit_nb_uniq_visitors::float::int, 0) AS exit_nb_uniq_visitors,
        avg_page_load_time,
        max_time_dom_processing,
        sum_time_spent,
        avg_time_dom_processing,
        bounce_rate,
        nb_hits_with_time_dom_processing,
        entry_nb_actions,
        max_time_transfer,
        coalesce(entry_nb_uniq_visitors::float::int, 0) AS entry_nb_uniq_visitors,
        avg_time_on_page,
        actions_pagetitle,
        segment,
        nb_visits,
        coalesce(entry_bounce_count::float::int, 0) as entry_bounce_count,
        coalesce(exit_nb_visits::float::int, 0) as exit_nb_visits,
        min_time_transfer,
        nb_hits_with_time_server,
        max_time_server,
        avg_time_server,
        label,
        nb_hits_with_time_transfer,
        avg_time_transfer,
        coalesce(entry_nb_visits::float::int, 0) as entry_nb_visits,
        entry_sum_visit_length,
        nb_hits,
        nb_uniq_visitors,
        exit_rate
    FROM source
)
select * FROM renamed
  