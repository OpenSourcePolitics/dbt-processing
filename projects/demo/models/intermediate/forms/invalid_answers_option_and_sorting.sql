SELECT 
    all_answers.id,
    all_answers.decidim_user_id,
    all_answers.session_token,
    all_answers.ip_hash,
    all_answers.decidim_question_id,
    all_answers.question_type,
    all_answers.question_position,
    all_answers.answer,
    all_answers.sub_matrix_question,
    all_answers.custom_body,
    all_answers.sorting_position,
    all_answers.decidim_questionnaire_id,
    all_answers.body,
    all_answers.created_at,
    all_answers.author_status
FROM {{ref('all_answers_option_and_sorting')}} all_answers
LEFT JOIN {{ref('answers_option_and_sorting')}} answers
    USING (id)
WHERE answers.answer IS NULL