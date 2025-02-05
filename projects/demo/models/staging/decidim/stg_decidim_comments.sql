{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_comments_comments') }}
),
renamed as (
    SELECT
        id,
        decidim_commentable_type,
        decidim_commentable_id,
        decidim_author_id,
        created_at,
        updated_at,
        depth,
        alignment,
        decidim_user_group_id,
        decidim_root_commentable_type,
        decidim_root_commentable_id,
        decidim_author_type,
        body::jsonb->>'{{ lang }}' as body,
        comments_count
    FROM source
)
SELECT * FROM renamed
  