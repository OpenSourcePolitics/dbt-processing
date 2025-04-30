{% set lang = var('DBT_LANG', 'fr') %}

SELECT
  id,
  decidim_question_id,
  TRIM(body::jsonb->> '{{ lang }}') AS body,
  free_text
FROM {{ source('decidim', 'decidim_forms_answer_options') }}
