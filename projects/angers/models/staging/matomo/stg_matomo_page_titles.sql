WITH source as (
      SELECT * FROM {{ source('matomo', 'page_titles') }}
),
renamed as (
    select
        date,
        max_time_generation,
        nb_hits_with_time_generation,
        coalesce(exit_nb_uniq_visitors::float::int, 0) as exit_nb_uniq_visitors,
        avg_page_load_time,
        min_time_generation,
        sum_time_spent,
        index,
        bounce_rate,
        label,
        entry_nb_actions,
        coalesce(entry_nb_visits::float::int, 0) as entry_nb_visits,
        entry_sum_visit_length,
        coalesce(entry_nb_uniq_visitors::float::int, 0) as entry_nb_uniq_visitors,
        avg_time_on_page,
        actions_pagetitle,
        segment,
        nb_visits,
        nb_hits,
        coalesce(entry_bounce_count::float::int, 0) as entry_bounce_count,
        nb_uniq_visitors,
        exit_rate,
        coalesce(exit_nb_visits::float::int, 0) as exit_nb_visits,
        avg_time_generation
    FROM source
)
select * from renamed
  