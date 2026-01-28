{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
      {'columns': ['decidim_questionnaire_id'], 'type': 'btree'},
      {'columns': ['question_type'], 'type': 'btree'},
    ]
)}}

{% set lang = var('DBT_LANG', 'fr') %}

SELECT
    id,
    decidim_questionnaire_id,
    position,
    question_type,
    mandatory,
    body::jsonb->>'{{ lang }}' AS body,
    description,
    max_choices,
    created_at,
    updated_at,
    max_characters,
    {{ coalesce_legacy_and_new_columns(source('decidim', 'decidim_blogs_posts'), 'answer_options_count', 'responses_options_count') }},
    {{ get_column_if_exists(source('decidim', 'decidim_forms_questions'), 'matrix_rows_count', 'INTEGER') }},
    {{ get_column_if_exists(source('decidim', 'decidim_forms_questions'), 'display_conditions_count', 'INTEGER') }},
    {{ get_column_if_exists(source('decidim', 'decidim_forms_questions'), 'display_conditions_for_other_questions_count', 'INTEGER') }},
    {{ get_column_if_exists(source('decidim', 'decidim_forms_questions'), 'survey_responses_published_at', 'TIMESTAMP') }}
FROM {{ source('decidim', 'decidim_forms_questions') }}  