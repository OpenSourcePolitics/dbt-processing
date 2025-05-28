SELECT
    *
FROM {{ ref('all_forms_answers')}}
WHERE answer IN ('separator', 'title_and_description')
