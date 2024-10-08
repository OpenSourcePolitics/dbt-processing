WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_attachments') }}
),
renamed as (
    SELECT
        id,
        title,
        description,
        file,
        content_type,
        file_size,
        attached_to_id,
        created_at,
        updated_at,
        attached_to_type,
        weight,
        attachment_collection_id
    FROM source
)
SELECT * FROM renamed
  