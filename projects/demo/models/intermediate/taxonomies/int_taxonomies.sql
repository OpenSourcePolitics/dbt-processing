SELECT
    decidim_taxonomies.id,
    decidim_taxonomies.name,
    decidim_taxonomies.decidim_organization_id,
    decidim_taxonomies.parent_id,
    decidim_taxonomies.weight,
    decidim_taxonomies.children_count,
    decidim_taxonomies.taxonomizations_count,
    decidim_taxonomies.created_at,
    decidim_taxonomies.updated_at,
    decidim_taxonomies.filters_count,
    decidim_taxonomies.filter_items_count,
    decidim_taxonomies.part_of,
    EXISTS (
        SELECT 1 FROM jsonb_array_elements(decidim_taxonomies.part_of) AS elem
        WHERE elem::text = '1'
    ) AS is_scope,
    EXISTS (
        SELECT 1 FROM jsonb_array_elements(decidim_taxonomies.part_of) AS elem
        WHERE elem::text = '2'
    ) AS is_category,
    (CASE WHEN decidim_taxonomies.parent_id IS NOT NULL AND decidim_taxonomies.parent_id != 2
        THEN TRUE
        ELSE FALSE
    END) as is_subtaxonomy
FROM {{ ref ("stg_decidim_taxonomies") }}  as decidim_taxonomies
JOIN {{ ref ("int_organizations")}}  AS decidim_organizations ON decidim_organization_id = decidim_organizations.id
