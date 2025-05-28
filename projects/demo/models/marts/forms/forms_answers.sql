SELECT
    *
FROM {{ ref('all_forms_answers')}}
WHERE answer NOT IN ('separator', 'title_and_description')
