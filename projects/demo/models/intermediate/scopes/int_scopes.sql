-- Due to ARRAY bug in test, we create an intermediate scopes without the column part_of

SELECT
    decidim_scopes.id,
    decidim_scopes.decidim_organization_id,
    decidim_scopes.created_at,
    decidim_scopes.updated_at,
    {{ int_scopes_default_name('decidim_scopes.name') }} AS name,
    decidim_scopes.scope_type_id,
    decidim_scopes.parent_id,
    decidim_scopes.code
FROM {{ ref ("stg_decidim_scopes") }}  as decidim_scopes
