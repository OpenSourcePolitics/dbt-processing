SELECT
    decidim_forms_answers.id,
    decidim_forms_answers.decidim_user_id,
    decidim_forms_answers.session_token,
    decidim_forms_answers.ip_hash,
    decidim_forms_answers.decidim_question_id,
    decidim_forms_answers.question_type,
    decidim_forms_answers.question_position,
    decidim_forms_answers.answer,
    decidim_forms_answers.sub_matrix_question,
    decidim_forms_answers.custom_body,
    decidim_forms_answers.sorting_position,
    decidim_forms_answers.decidim_questionnaire_id,
    decidim_forms_answers.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status
FROM {{ref('all_answers_option_and_sorting')}} decidim_forms_answers
WHERE invalid_question_id IS false
--  OR invalid_choice_body IS false