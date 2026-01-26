WITH main_taxonomies AS (
    SELECT
        decidim_taxonomies.id AS id,
        decidim_taxonomies.name AS taxonomy_name,
        0 AS child_id,
        '' AS child_name,
        decidim_taxonomizations.categorizable_id,
        decidim_taxonomizations.categorizable_type
    FROM {{ ref ("stg_decidim_taxonomizations")}} AS decidim_taxonomizations
    JOIN {{ ref ("stg_decidim_taxonomies")}} AS decidim_taxonomies ON decidim_taxonomies.id = decidim_taxonomizations.decidim_taxonomy_id
    WHERE decidim_taxonomies.parent_id IS NULL
),
sub_taxonomies AS (
    SELECT
        parent_taxonomies.id AS id,
        parent_taxonomies.name AS taxonomy_name,
        decidim_taxonomies.id AS child_id,
        decidim_taxonomies.name AS child_name,
        decidim_taxonomizations.categorizable_id,
        decidim_taxonomizations.categorizable_type
    FROM {{ ref ("stg_decidim_taxonomizations")}} AS decidim_taxonomizations
    JOIN {{ ref ("stg_decidim_taxonomies")}} AS decidim_taxonomies ON decidim_taxonomies.id = decidim_taxonomies.decidim_taxonomy_id
    LEFT JOIN {{ ref ("stg_decidim_taxonomies")}} AS parent_taxonomies ON decidim_taxonomies.parent_id = parent_taxonomies.id
    WHERE decidim_taxonomies.parent_id IS NOT NULL
),
taxonomies AS (
    SELECT * FROM main_taxonomies
    UNION ALL
    SELECT * FROM sub_taxonomies
)
SELECT  * FROM taxonomies