WITH
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Debates::Debate') }}
),
scopes_from_taxonomies AS (
    {{ import_scopes_from_taxonomies('Decidim::Debates::Debate') }}
),
categories_from_taxonomies AS (
    {{ import_categories_from_taxonomies('Decidim::Debates::Debate') }}
),
categorizations AS (
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
    scopes_from_taxonomies.child_name AS decidim_scope_name,
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
    COALESCE(categories_from_taxonomies.categories, categorizations.categories) AS categories,
    COALESCE(
        {{ categorization_first_category('categories_from_taxonomies.categories[1]') }},
        {{ categorization_first_category('categorizations.categories[1]') }}
        ) AS first_category,
    COALESCE(categories_from_taxonomies.sub_categories, categorizations.sub_categories) AS sub_categories,
    COALESCE(
        {{ categorization_first_sub_category('categories_from_taxonomies.sub_categories[1]') }},
        {{ categorization_first_sub_category('categorizations.sub_categories[1]') }}
    ) AS first_sub_category,
    {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
    taxonomizations.sub_taxonomies,
    {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }}
FROM {{ ref("stg_decidim_debates")}} AS decidim_debates_debates
    JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id
    LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_debates_debates.id
    LEFT JOIN scopes_from_taxonomies on scopes_from_taxonomies.taxonomizable_id = decidim_debates_debates.id
    LEFT JOIN categories_from_taxonomies on categories_from_taxonomies.taxonomizable_id = decidim_debates_debates.id
    LEFT JOIN categorizations on categorizations.categorizable_id = decidim_debates_debates.id
    LEFT JOIN {{ ref("int_scopes")}} AS decidim_scopes ON decidim_scopes.id = decidim_debates_debates.decidim_scope_id
WHERE decidim_debates_debates.deleted_at IS NULL
