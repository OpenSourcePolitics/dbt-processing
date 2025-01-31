{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
      {'columns': ['decidim_question_id'], 'type': 'btree'},
    ]
)}}

SELECT
    id,
    body,
    decidim_user_id,
    decidim_questionnaire_id,
    decidim_question_id,
    created_at,
    {{ int_forms_answers_translate_author_status('decidim_user_id') }} AS author_status,
    updated_at,
    session_token,
    ip_hash
FROM {{ ref("stg_decidim_forms_answers")}}