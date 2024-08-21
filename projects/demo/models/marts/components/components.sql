-- Warning: are not taken by default into account Conferences, Consultations, Elections, Initiatives, Votations
WITH assemblies_spaces AS (
    SELECT
        id AS ps_id,
        published_at AS ps_published_at,
        title AS ps_title,
        subtitle AS ps_subtitle,
        slug AS ps_slug,
        decidim_organization_id,
        'Decidim::Assembly' AS ps_type,
        'assemblies' AS ps_space_type_slug
    FROM {{ ref ("stg_decidim_assemblies")}}
),
participatory_processes_spaces AS (
    SELECT
        id AS ps_id, 
        published_at AS ps_published_at, 
        title AS ps_title, 
        subtitle AS ps_subtitle, 
        slug AS ps_slug, 
        decidim_organization_id, 
        'Decidim::ParticipatoryProcess' AS ps_type,
        'processes' AS ps_space_type_slug
    FROM {{ ref ("stg_decidim_participatory_processes")}}
), 
participatory_spaces AS (
    SELECT * FROM assemblies_spaces 
    UNION ALL
    SELECT * FROM participatory_processes_spaces
),
components AS (
    SELECT 
        decidim_components.id,
        decidim_components.manifest_name,
        decidim_components.translated_manifest_name,
        concat(decidim_components.name, ' (', decidim_components.translated_manifest_name, ')') AS component_name,
        decidim_components.published_at,
        decidim_components.created_at,
        concat('https://',decidim_organizations.host,'/', participatory_spaces.ps_space_type_slug, '/', participatory_spaces.ps_slug,'/f/', decidim_components.id) AS component_url,
        participatory_spaces.ps_id, 
        participatory_spaces.ps_published_at, 
        participatory_spaces.ps_title, 
        participatory_spaces.ps_subtitle, 
        participatory_spaces.ps_slug, 
        participatory_spaces.ps_type,
        participatory_spaces.ps_space_type_slug,
        concat('https://',decidim_organizations.host,'/', participatory_spaces.ps_space_type_slug, '/', participatory_spaces.ps_slug,'/') AS ps_url,
        decidim_organization_id, 
        decidim_organizations.host AS organization_host
    FROM {{ ref ("int_components")}} AS decidim_components
    JOIN participatory_spaces ON participatory_spaces.ps_type = decidim_components.participatory_space_type AND decidim_components.participatory_space_id = participatory_spaces.ps_id 
    JOIN {{ ref ("int_organizations")}} AS decidim_organizations ON decidim_organizations.id = participatory_spaces.decidim_organization_id
    WHERE participatory_spaces.ps_published_at IS NOT NULL
)
SELECT * FROM components
