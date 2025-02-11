{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_initiatives'
) %}

{% if relation is not none %}
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
    FROM {{ source('decidim', 'decidim_initiatives') }}
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS TEXT) AS title,
        CAST(NULL AS TEXT) AS description,
        CAST(NULL AS INTEGER) AS decidim_organization_id,
        CAST(NULL AS INTEGER) AS decidim_author_id,
        CAST(NULL AS TIMESTAMP) AS published_at,
        CAST(NULL AS INTEGER) AS state,
        CAST(NULL AS TEXT) AS signature_type,
        CAST(NULL AS TIMESTAMP) AS signature_start_date,
        CAST(NULL AS TIMESTAMP) AS signature_end_date,
        CAST(NULL AS TEXT) AS answer,
        CAST(NULL AS TIMESTAMP) AS answered_at,
        CAST(NULL AS TEXT) AS answer_url,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS INTEGER) AS decidim_user_group_id,
        CAST(NULL AS TEXT) AS hashtag,
        CAST(NULL AS INTEGER) AS scoped_type_id,
        CAST(NULL AS TIMESTAMP) AS first_progress_notification_at,
        CAST(NULL AS TIMESTAMP) AS second_progress_notification_at,
        CAST(NULL AS TEXT) AS decidim_author_type,
        CAST(NULL AS TEXT) AS reference,
        CAST(NULL AS TEXT) AS online_votes,
        CAST(NULL AS TEXT) AS offline_votes,
        CAST(NULL AS INTEGER) AS decidim_area_id,
        CAST(NULL AS INTEGER) AS comments_count,
        CAST(NULL AS INTEGER) AS follows_count
    LIMIT 0
{% endif %}
