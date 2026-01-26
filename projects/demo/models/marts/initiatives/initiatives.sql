-- State names were inferred from Decidim source code, see https://github.com/decidim/decidim/blob/ea816fbe8c21ed37d7f5706c081ec65b1b791d32/decidim-initiatives/spec/helpers/decidim/initiatives/initiative_helper_spec.rb#L9 and https://github.com/decidim/decidim/blob/ea816fbe8c21ed37d7f5706c081ec65b1b791d32/decidim-initiatives/config/locales/fr.yml#L324
-- State 6 is actually from a in-house customization, see https://github.com/OpenSourcePolitics/decidim-module-transparent_trash
-- Originally written for CESE, hence the French names
WITH decidim_organizations AS (
    -- Assumption: There is only one organization, so we select the first available host
    SELECT 
      id,
      host
    FROM {{ ref('int_organizations') }}
    LIMIT 1
)
    SELECT
        decidim_initiatives.id,
        decidim_initiatives.title,
        decidim_initiatives.description,
        decidim_initiatives.decidim_author_id,
        decidim_initiatives.published_at,
        decidim_initiatives.parsed_state,
        decidim_initiatives.state,
        decidim_initiatives.signature_type,
        decidim_initiatives.signature_start_date,
        decidim_initiatives.signature_end_date,
        decidim_initiatives.answer,
        decidim_initiatives.answered_at,
        decidim_initiatives.answer_url,
        decidim_initiatives.created_at,
        decidim_initiatives.decidim_user_group_id,
        decidim_initiatives.scoped_type_id,
        decidim_initiatives.decidim_author_type,
        decidim_initiatives.parsed_online_votes,
        decidim_initiatives.parsed_offline_votes,
        decidim_initiatives.sum_votes,
        decidim_initiatives.comments_count,
        decidim_initiatives.follows_count,
        CONCAT('https://', decidim_organizations.host, '/initiatives/i-', decidim_initiatives.id) AS url,
        decidim_initiatives_type_scopes.supports_required,
        decidim_initiatives_type_scopes.decidim_taxonomy_id,
        decidim_areas.id AS area_id,
        coalesce(nullif(decidim_areas.name::jsonb->>'fr', ''), 'Pas de sous catégorie') AS area_name,
        coalesce(nullif(decidim_area_types.name::jsonb->>'fr',''), 'Pas de catégorie') AS area_type_name,
        decidim_initiatives.resource_type,
        decidim_initiatives.id_as_text
    FROM {{ ref("int_initiatives")}} decidim_initiatives
        JOIN {{ ref("stg_decidim_initiatives_type_scopes")}} decidim_initiatives_type_scopes on decidim_initiatives.scoped_type_id = decidim_initiatives_type_scopes.id
        LEFT JOIN {{ ref("stg_decidim_areas")}} decidim_areas on decidim_areas.id = decidim_initiatives.decidim_area_id
        LEFT JOIN {{ ref("stg_decidim_area_types")}} decidim_area_types on decidim_area_types.id = decidim_areas.area_type_id
        CROSS JOIN decidim_organizations
        WHERE decidim_organizations.id = decidim_initiatives.decidim_organization_id