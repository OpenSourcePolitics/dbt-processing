WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_initiatives_votes') }}
),
renamed AS (
    select
        id,
        decidim_initiative_id,
        decidim_author_id,
        created_at,
        updated_at,
        encrypted_metadata,
        timestamp,
        hash_id,
        decidim_scope_id
    FROM source
)
select * FROM renamed
  