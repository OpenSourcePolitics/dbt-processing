SELECT DISTINCT ON (
    all_answers.session_token,
    all_answers.question_title,
    all_answers.answer,
    all_answers.custom_body,
    all_answers.position
)
*
FROM {{ ref('all_forms_answers')}} all_answers
WHERE answer NOT IN ('separator', 'title_and_description')
