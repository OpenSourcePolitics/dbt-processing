{% set lang = var('DBT_LANG', 'fr') %}

{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_form_response_options'
) %}


{% if relation is not none %}
    SELECT
        id,
        body::jsonb->>'{{ lang }}' AS body,
        free_text,
        decidim_question_id
      FROM {{ source('decidim', 'decidim_forms_response_options') }}
{% else %}
    SELECT
        id,
        body::jsonb->>'{{ lang }}' AS body,
        free_text,
        decidim_question_id
      FROM {{ source('decidim', 'decidim_forms_answer_options') }}
{% endif %}