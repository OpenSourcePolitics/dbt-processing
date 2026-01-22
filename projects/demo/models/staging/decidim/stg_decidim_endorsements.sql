{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_likes'
) %}

{% if relation is not none %}
SELECT
    id,
    resource_type,
    resource_id,
    decidim_author_type,
    decidim_author_id,
    decidim_user_group_id,
    created_at,
    updated_at
FROM {{ source('decidim', 'decidim_likes') }}

{% else %}
 SELECT
    id,
    resource_type,
    resource_id,
    decidim_author_type,
    decidim_author_id,
    decidim_user_group_id,
    created_at,
    updated_at
FROM {{ source('decidim', 'decidim_endorsements') }}

{% endif %}