SELECT 
    *
FROM {{ref('all_answers_option_and_sorting')}} all_answers
WHERE invalid_question_id
    OR invalid_choice_body