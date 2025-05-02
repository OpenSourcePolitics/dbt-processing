{{ config(
    indexes=[
      {'columns': ['decidim_questionnaire_id'], 'type': 'btree'},
    ]
)}}

SELECT DISTINCT
    decidim_forms_answers.decidim_user_id,
    decidim_forms_answers.session_token,
    decidim_forms_answers.ip_hash,
    decidim_forms_questions.question_type,
    decidim_forms_questions.position AS "position",
    decidim_forms_answer_choices.body::text AS "answer",
    decidim_forms_question_matrix_rows.body AS sub_matrix_question,
    COALESCE(decidim_forms_answer_choices.custom_body, '') AS custom_body,
    -1 AS sorting_position,
    decidim_forms_questions.decidim_questionnaire_id,
    decidim_forms_questions.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status
FROM {{ ref('int_forms_answers') }} decidim_forms_answers
JOIN {{ ref('stg_decidim_forms_questions') }} AS decidim_forms_questions ON decidim_forms_questions.id = decidim_forms_answers.decidim_question_id
JOIN {{ ref('stg_decidim_forms_answer_choices') }} decidim_forms_answer_choices ON decidim_forms_answer_choices.decidim_answer_id = decidim_forms_answers.id
JOIN {{ ref('stg_decidim_forms_question_matrix_rows') }} decidim_forms_question_matrix_rows ON decidim_forms_question_matrix_rows.id = decidim_forms_answer_choices.decidim_question_matrix_row_id
WHERE question_type = ANY('{matrix_single, matrix_multiple}'::text[])
