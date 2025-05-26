{% set lang = var('DBT_LANG', 'fr') %}

with source as (
        select * from {{ source('decidim', 'decidim_forms_answer_options') }}
  ),
  renamed as (
      select
        id,
        body::jsonb->>'{{ lang }}' AS body,
        free_text,
        decidim_question_id
      from source
  )
  select * from renamed
    