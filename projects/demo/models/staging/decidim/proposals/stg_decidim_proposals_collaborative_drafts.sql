WITH source as (
      SELECT * FROM {{ source('decidim', 'decidim_proposals_collaborative_drafts') }}
),
renamed as (
    select
        id,
        title,
        body,
        decidim_component_id,
        decidim_scope_id,
        state,
        reference,
        address,
        latitude,
        longitude,
        published_at,
        authors_count,
        versions_count,
        contributions_count,
        created_at,
        updated_at,
        coauthorships_count,
        comments_count,
        follows_count

    from source
)
select * from renamed
  