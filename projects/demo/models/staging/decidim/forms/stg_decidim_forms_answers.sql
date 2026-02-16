{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_forms_responses'
) %}

{% if relation is not none %}
    SELECT
        id,
        body,
        decidim_user_id,
        decidim_questionnaire_id,
        decidim_question_id,
        created_at,
        updated_at,
        session_token,
        ip_hash
    FROM {{ source('decidim', 'decidim_forms_responses') }}
{% else %}
    SELECT
        id,
        body,
        decidim_user_id,
        decidim_questionnaire_id,
        decidim_question_id,
        created_at,
        updated_at,
        session_token,
        ip_hash
    FROM {{ source('decidim', 'decidim_forms_answers') }}
{% endif %}