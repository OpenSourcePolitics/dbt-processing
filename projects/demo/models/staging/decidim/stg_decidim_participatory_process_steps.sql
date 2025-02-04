{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_participatory_process_steps') }}
),
renamed AS (
    select
        id,
        title::jsonb->>'{{ lang }}' as title,
        title::jsonb->>'{{ lang }}' as description,
        start_date,
        end_date,
        decidim_participatory_process_id,
        created_at,
        updated_at,
        active,
        position,
        cta_text,
        cta_path

    FROM source
)
select * FROM renamed
  