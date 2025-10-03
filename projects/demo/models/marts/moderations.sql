{% set reportable_tables = [
    {"table": "comments", "type": "Decidim::Comments::Comment"},
    {"table": "proposals", "type": "Decidim::Proposals::Proposal"}
] %}

WITH reported_content AS (
    {% for reportable in reportable_tables %}
    SELECT
        moderations.*,
        {{ ref(reportable.table) }}.decidim_component_id AS "decidim_component_id",
        {{ ref(reportable.table) }}.url AS "reported_content_url"
    FROM {{ ref(reportable.table) }}
    JOIN {{ ref("stg_decidim_moderations") }} AS moderations
        on moderations.decidim_reportable_id = {{ ref(reportable.table) }}.id
        and moderations.decidim_reportable_type = '{{ reportable.type }}'
    {% if not loop.last %} union all {% endif %}
    {% endfor %}
)

SELECT
    id,
    decidim_participatory_space_id,
    decidim_reportable_type,
    decidim_reportable_id,
    report_count,
    hidden_at,
    created_at,
    updated_at,
    decidim_participatory_space_type,
    decidim_component_id,
    reported_content_url,
    reported_content AS reported_content_contents,
    (CASE WHEN hidden_at IS NOT NULL THEN true ELSE false END) AS is_hidden
FROM reported_content