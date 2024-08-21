WITH forms_meetings AS (
    SELECT decidim_forms_questionnaires.id AS questionnaire_id,
        decidim_forms_questionnaires.title,
        decidim_meetings_meetings.decidim_component_id
    from {{ ref("stg_decidim_forms_questionnaires")}} decidim_forms_questionnaires
        JOIN {{ ref("stg_decidim_meetings")}} decidim_meetings_meetings on decidim_meetings_meetings.id = questionnaire_for_id
    where questionnaire_for_type = 'Decidim::Meetings::Meeting'
), forms_surveys AS (
    select decidim_forms_questionnaires.id AS questionnaire_id,
        decidim_forms_questionnaires.title,
        decidim_surveys_surveys.decidim_component_id
    from decidim_forms_questionnaires
        JOIN {{ ref("stg_decidim_surveys")}} decidim_surveys_surveys on decidim_surveys_surveys.id = questionnaire_for_id
    where questionnaire_for_type = 'Decidim::Surveys::Survey'
), forms AS (
    select * from forms_meetings union all
    select * from forms_surveys 
)
select
    forms.questionnaire_id AS id,
    title::jsonb->>'fr' AS title,
    decidim_components.id AS decidim_component_id,
    concat ('https://',organization_host, '/', ps_space_type_slug,'/', ps_slug, '/f/', decidim_component_id) AS "questionnaire_url"
from forms
    JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id