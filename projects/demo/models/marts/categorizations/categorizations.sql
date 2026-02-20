WITH main_categories AS (
    SELECT
        decidim_categories.id AS category_id,
        decidim_categories.name AS category_name,
        0 AS child_id,
        '' AS child_name,
        decidim_categorizations.categorizable_id,
        decidim_categorizations.categorizable_type
    FROM {{ ref ("stg_decidim_categorizations")}} AS decidim_categorizations
    JOIN {{ ref ("stg_decidim_categories")}} AS decidim_categories ON decidim_categories.id = decidim_categorizations.decidim_category_id
    WHERE decidim_categories.parent_id IS NULL
), 
sub_categories AS (  
    SELECT
        parent_categories.id AS category_id,
        parent_categories.name AS category_name,
        decidim_categories.id AS child_id,
        decidim_categories.name AS child_name,
        decidim_categorizations.categorizable_id,
        decidim_categorizations.categorizable_type
    FROM {{ ref ("stg_decidim_categorizations")}} AS decidim_categorizations
    JOIN {{ ref ("stg_decidim_categories")}} AS decidim_categories ON decidim_categories.id = decidim_categorizations.decidim_category_id
    LEFT JOIN {{ ref ("stg_decidim_categories")}} AS parent_categories ON decidim_categories.parent_id = parent_categories.id
    WHERE decidim_categories.parent_id IS NOT NULL
), 
categories AS (
    SELECT * FROM main_categories 
    UNION ALL
    SELECT * FROM sub_categories
)
SELECT  * FROM categories
