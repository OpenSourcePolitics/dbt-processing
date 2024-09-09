{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
    ]
)}}

WITH forms_meetings AS (
    SELECT decidim_forms_questionnaires.id AS questionnaire_id,
        decidim_forms_questionnaires.title,
        decidim_meetings_meetings.decidim_component_id
    FROM {{ ref("stg_decidim_forms_questionnaires")}} decidim_forms_questionnaires
    JOIN {{ ref("stg_decidim_meetings")}} decidim_meetings_meetings ON decidim_meetings_meetings.id = decidim_forms_questionnaires.questionnaire_for_id
    WHERE questionnaire_for_type = 'Decidim::Meetings::Meeting'
), forms_surveys AS (
    SELECT decidim_forms_questionnaires.id AS questionnaire_id,
        decidim_forms_questionnaires.title,
        decidim_surveys_surveys.decidim_component_id
    FROM decidim_forms_questionnaires
    JOIN {{ ref("stg_decidim_surveys")}} decidim_surveys_surveys ON decidim_surveys_surveys.id = questionnaire_for_id
    WHERE questionnaire_for_type = 'Decidim::Surveys::Survey'
), forms AS (
    SELECT * FROM forms_meetings UNION ALL
    SELECT * FROM forms_surveys 
)
SELECT
    forms.questionnaire_id AS id,
    title::jsonb->>'fr' AS title,
    decidim_components.id AS decidim_component_id,
    concat ('https://',organization_host, '/', ps_space_type_slug,'/', ps_slug, '/f/', decidim_component_id) AS "questionnaire_url"
FROM forms
JOIN {{ ref("components")}} decidim_components ON decidim_components.id = forms.decidim_component_id