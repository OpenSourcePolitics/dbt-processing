
  
    

  create  table "test_lyon"."prod"."forms_answers__dbt_tmp"
  
  
    as
  
  (
    

WITH answers_short_and_long_answer AS (
    SELECT * FROM "test_lyon"."prod"."answers_short_and_long_answer"
), answers_option_and_sorting AS (
    SELECT * FROM "test_lyon"."prod"."answers_option_and_sorting"
), answers_matrix AS (
    SELECT * FROM "test_lyon"."prod"."answers_matrix"
), answers_file AS (
    SELECT * FROM "test_lyon"."prod"."answers_file"
), answers AS (
    SELECT * FROM answers_short_and_long_answer
    UNION ALL
    SELECT * FROM answers_option_and_sorting
    UNION ALL
    SELECT * FROM answers_matrix
    UNION ALL
    SELECT * FROM answers_file
)

SELECT
    answers.decidim_user_id,
    answers.session_token,
    answers.ip_hash,
    answers.question_type,
    answers.body AS question_title,
    btrim(answers.answer, '"') AS answer,
    answers.sub_matrix_question,
    answers.custom_body,
    answers.sorting_position,
    answers.decidim_questionnaire_id,
    decidim_forms_questionnaires.title AS form_title,
    decidim_forms_questionnaires.decidim_component_id,
    (CASE answers.sorting_position
      WHEN 0 THEN 10
      WHEN 1 THEN 9
      WHEN 2 THEN 8
      WHEN 3 THEN 7
      WHEN 4 THEN 6
      WHEN 5 THEN 5
      WHEN 6 THEN 4
      WHEN 7 THEN 3
      WHEN 8 THEN 2
      WHEN 9 THEN 1
      ELSE -1
    END) AS sorting_points,
    answers.position,
    answers.created_at,
    answers.author_status
FROM answers
JOIN "test_lyon"."prod"."forms" AS decidim_forms_questionnaires ON decidim_forms_questionnaires.id = answers.decidim_questionnaire_id
ORDER BY session_token, position
  );
  