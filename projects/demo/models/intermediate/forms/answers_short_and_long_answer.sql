{{ config(
    indexes=[
      {'columns': ['decidim_questionnaire_id'], 'type': 'btree'},
    ]
)}}

SELECT
    decidim_user_id,
    session_token,
    ip_hash,
    question_type,
    position,
    {{ int_forms_translate_short_and_long_answers('decidim_forms_answers.body') }} AS answer,
    '' AS sub_matrix_question,
    '' AS custom_body,
    -1 AS sorting_position,
    decidim_forms_questions.decidim_questionnaire_id,
    decidim_forms_questions.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status
FROM {{ ref('int_forms_answers') }} decidim_forms_answers
JOIN {{ ref('stg_decidim_forms_questions') }} AS decidim_forms_questions ON decidim_forms_questions.id = decidim_forms_answers.decidim_question_id
WHERE question_type = ANY('{short_answer,long_answer}'::text[])
