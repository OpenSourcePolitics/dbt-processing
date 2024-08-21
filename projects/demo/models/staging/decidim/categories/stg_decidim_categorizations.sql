WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_categorizations') }}
),
renamed AS (
    SELECT
        id,
        decidim_category_id,
        categorizable_type,
        categorizable_id,
        created_at,
        updated_at
    FROM source
)
SELECT * FROM renamed
  