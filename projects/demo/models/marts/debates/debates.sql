WITH categorizations AS (
    {{ categorizations_filter('Decidim::Debates::Debate') }}
)
SELECT
    decidim_debates_debates.id,
    decidim_debates_debates.title,
    decidim_debates_debates.description,
    decidim_debates_debates.start_time,
    decidim_debates_debates.end_time,
    decidim_debates_debates.decidim_component_id,
    decidim_debates_debates.decidim_author_id,
    decidim_debates_debates.created_at,
    decidim_debates_debates.closed_at,
    decidim_components.ps_slug,
    concat(
        'https://',
        decidim_components.organization_host,
        '/',
        decidim_components.ps_space_type_slug,
        '/',
        decidim_components.ps_slug,
        '/f/',
        decidim_components.id,
        '/debates/',
        decidim_debates_debates.id
    ) AS debate_url,
    decidim_debates_debates.resource_type,
    categorizations.categories,
    {{ categorization_first_category('categorizations.categories[1]') }},
    categorizations.sub_categories,
    {{ categorization_first_sub_category('categorizations.sub_categories[1]') }}
FROM {{ ref("stg_decidim_debates")}} AS decidim_debates_debates
    JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id
    LEFT JOIN categorizations on categorizations.categorizable_id = decidim_debates_debates.id
WHERE decidim_debates_debates.deleted_at IS NULL
