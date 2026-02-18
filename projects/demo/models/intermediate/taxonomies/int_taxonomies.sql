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
    (CASE WHEN JSON_EXISTS(decidim_taxonomies.part_of, '1') THEN true ELSE false END) AS is_scope
FROM {{ ref ("stg_decidim_taxonomies") }}  as decidim_taxonomies
JOIN {{ ref ("int_organizations")}}  AS decidim_organizations ON decidim_organization_id = decidim_organizations.id
