{% set lang = var('DBT_LANG', 'fr') %}

    SELECT
        id,
        manifest_name,
        name::jsonb->>'{{ lang }}' AS name,
        participatory_space_id,
        participatory_space_type,
        settings,
        weight,
        permissions,
        {{ get_column_if_exists(source('decidim', 'decidim_components'), 'visible', 'BOOLEAN') }},
        published_at,
        created_at,
        updated_at,
        {{ get_column_if_exists(source('decidim', 'decidim_components'), 'deleted_at', 'TIMESTAMP') }}
    FROM {{ source('decidim', 'decidim_components') }}