WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_moderations') }}
),
renamed AS (
    SELECT
        id,
        decidim_participatory_space_id,
        decidim_reportable_type,
        decidim_reportable_id,
        report_count,
        hidden_at,
        created_at,
        updated_at,
        decidim_participatory_space_type,
        reported_content
    FROM source
)
SELECT * FROM renamed
  