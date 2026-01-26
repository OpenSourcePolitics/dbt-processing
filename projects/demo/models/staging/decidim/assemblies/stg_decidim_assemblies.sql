{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_assemblies') }}
),
renamed AS (
    SELECT
        id,
        slug,
        decidim_organization_id,
        created_at,
        updated_at,
        title::jsonb->>'{{ lang }}' AS title,
        subtitle::jsonb->>'{{ lang }}' AS subtitle,
        short_description,
        description,
        hero_image,
        banner_image,
        promoted,
        published_at,
        developer_group,
        meta_scope,
        local_area,
        target,
        participatory_scope,
        participatory_structure,
        decidim_scope_id,
        scopes_enabled,
        private_space,
        reference,
        decidim_area_id,
        parent_id,
        parents_path,
        children_count,
        purpose_of_action,
        composition,
        creation_date,
        created_by,
        created_by_other,
        {{ get_column_if_exists(source('decidim', 'decidim_participatory_processes'), 'deleted_at', 'TIMESTAMP') }},
        duration,
        included_at,
        closing_date,
        closing_date_reason,
        internal_organisation,
        is_transparent,
        special_features,
        twitter_handler,
        instagram_handler,
        facebook_handler,
        youtube_handler,
        github_handler,
        decidim_assemblies_type_id,
        weight,
        follows_count
    FROM source
)
SELECT * FROM renamed
  