SELECT
    decidim_components.id,
    decidim_components.manifest_name,
    -- For Metabase usage, we translate the name in French
    (CASE decidim_components.manifest_name
        WHEN 'accountability' THEN 'Suivi'
        WHEN 'pages' THEN 'Page'
        WHEN 'budgets' THEN 'Budgets'
        WHEN 'meetings' THEN 'Rencontres'
        WHEN 'proposals' THEN 'Propositions'
        WHEN 'surveys' THEN 'Enquêtes'
        WHEN 'blogs' THEN 'Blogs'
        ELSE decidim_components.manifest_name
        END
    ) AS translated_manifest_name,
    decidim_components.name,
    decidim_components.participatory_space_id,
    decidim_components.participatory_space_type,
    decidim_components.settings,
    decidim_components.weight,
    decidim_components.permissions,
    decidim_components.published_at,
    decidim_components.created_at,
    decidim_components.updated_at
    FROM {{ ref ("stg_decidim_components")}} as decidim_components