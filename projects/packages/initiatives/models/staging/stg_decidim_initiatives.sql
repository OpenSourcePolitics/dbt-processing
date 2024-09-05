WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_initiatives') }}
),
renamed AS (
    SELECT
        id,
        title,
        description,
        decidim_organization_id,
        decidim_author_id,
        published_at,
        state,
        signature_type,
        signature_start_date,
        signature_end_date,
        answer,
        answered_at,
        answer_url,
        created_at,
        updated_at,
        decidim_user_group_id,
        hashtag,
        scoped_type_id,
        first_progress_notification_at,
        second_progress_notification_at,
        decidim_author_type,
        reference,
        online_votes,
        offline_votes,
        decidim_area_id,
        comments_count,
        follows_count
    FROM source
)
SELECT * FROM renamed
  