WITH org AS (
    -- Assumption: There is only one organization, so we select the first available host
    SELECT host
    FROM {{ ref('organizations') }}
    LIMIT 1
)
SELECT DISTINCT
    decidim_forms_answers.decidim_user_id,
    decidim_forms_answers.session_token,
    decidim_forms_answers.ip_hash,
    decidim_forms_questions.question_type,
    decidim_forms_questions.position AS "position",
    decidim_attachments.file AS "answer",
    '' AS "sub_matrix_question",
    CONCAT('https://', org.host, '/uploads/decidim/attachment/file/', decidim_attachments.id, '/', decidim_attachments.file) AS custom_body,
    -1 AS sorting_position,
    decidim_forms_questions.decidim_questionnaire_id,
    decidim_forms_questions.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status
FROM {{ ref('int_forms_answers') }} decidim_forms_answers
JOIN {{ ref('stg_decidim_forms_questions') }} AS decidim_forms_questions ON decidim_forms_questions.id = decidim_forms_answers.decidim_question_id
JOIN {{ ref('stg_decidim_attachments') }} decidim_attachments ON decidim_attachments.attached_to_id = decidim_forms_answers.id
CROSS JOIN org
WHERE kattached_to_type = 'Decidim::Forms::Answer'
