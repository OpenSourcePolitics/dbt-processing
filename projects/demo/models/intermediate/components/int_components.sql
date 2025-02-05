SELECT
    decidim_components.id,
    decidim_components.manifest_name,
    -- For Metabase usage, we translate the name in French
    {{ int_component_translate_manifest_name('decidim_components.manifest_name') }} AS translated_manifest_name,
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