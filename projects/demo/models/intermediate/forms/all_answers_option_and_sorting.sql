{{ config(
    indexes=[
      {'columns': ['decidim_questionnaire_id'], 'type': 'btree'},
    ]
)}}

SELECT DISTINCT
    decidim_forms_answers.id,
    decidim_forms_answers.decidim_user_id,
    decidim_forms_answers.session_token,
    decidim_forms_answers.ip_hash,
    decidim_forms_answers.decidim_question_id,
    decidim_forms_questions.question_type,
    decidim_forms_questions.position AS question_position,
    decidim_forms_answer_choices.body::text AS answer,
    decidim_forms_answer_options.body AS option_answer,
    '' AS sub_matrix_question,
    COALESCE(decidim_forms_answer_choices.custom_body, '') AS custom_body,
    (CASE question_type WHEN 'sorting' THEN decidim_forms_answer_choices.position ELSE -1 END) AS sorting_position,
    decidim_forms_questions.decidim_questionnaire_id,
    decidim_forms_questions.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status,
    decidim_forms_answer_choices.decidim_answer_option_id,
    (CASE WHEN decidim_forms_answer_options.decidim_question_id != decidim_forms_answers.decidim_question_id THEN true ELSE false END) AS invalid_question_id,
    (CASE WHEN decidim_forms_answer_options.body != decidim_forms_answer_choices.body THEN true ELSE false END) AS invalid_choice_body
FROM {{ ref('int_forms_answers') }} decidim_forms_answers
JOIN {{ ref('stg_decidim_forms_questions') }} AS decidim_forms_questions ON decidim_forms_questions.id = decidim_forms_answers.decidim_question_id
JOIN {{ ref('stg_decidim_forms_answer_choices') }} decidim_forms_answer_choices ON decidim_forms_answer_choices.decidim_answer_id = decidim_forms_answers.id
JOIN {{ ref('stg_decidim_forms_answer_options') }} decidim_forms_answer_options
  ON decidim_forms_answer_options.id = decidim_forms_answer_choices.decidim_answer_option_id
WHERE question_type = ANY('{single_option, multiple_option, sorting}'::text[])