{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_form_response_choices'
) %}

{% if relation is not none %}
    SELECT
        id,
        decidim_response_id AS decidim_answer_id,
        decidim_response_option_id AS decidim_answer_id,
        position,
        REPLACE(SUBSTR(body, 2, length(body) - 2)::text, '\"', '"') AS body,
        custom_body,
        decidim_question_matrix_row_id
    FROM {{ source('decidim', 'decidim_forms_response_choices') }}
 {% else %}
    SELECT
        id,
        decidim_answer_id,
        decidim_answer_option_id,
        position,
        REPLACE(SUBSTR(body, 2, length(body) - 2)::text, '\"', '"') AS body,
        custom_body,
        decidim_question_matrix_row_id
    FROM {{ source('decidim', 'decidim_forms_answer_choices') }}
{% endif %}

  