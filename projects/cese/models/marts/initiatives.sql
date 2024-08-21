-- State names were inferred from Decidim source code, see https://github.com/decidim/decidim/blob/ea816fbe8c21ed37d7f5706c081ec65b1b791d32/decidim-initiatives/spec/helpers/decidim/initiatives/initiative_helper_spec.rb#L9 and https://github.com/decidim/decidim/blob/ea816fbe8c21ed37d7f5706c081ec65b1b791d32/decidim-initiatives/config/locales/fr.yml#L324
-- State 6 is actually from a in-house customization, see https://github.com/OpenSourcePolitics/decidim-module-transparent_trash
-- Originally written for CESE, hence the French names

    SELECT
        decidim_initiatives.id,
        title::jsonb->>'fr' AS title,
        regexp_replace(decidim_initiatives.description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS description,
        decidim_author_id,
        published_at,
        (case state
          when 0 then 'Créée'
          when 1 then 'Validation technique'
          when 2 then 'Retirée'
          when 3 then 'Publiée'
          when 4 then 'Pas assez de signatures'
          when 5 then 'Assez de signatures'
          when 6 then 'Invalide'
        end) AS parsed_state,
        state,
        signature_type,
        signature_start_date,
        signature_end_date,
        regexp_replace(answer::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS answer,
        answered_at,
        answer_url,
        decidim_initiatives.created_at,
        decidim_user_group_id,
        hashtag,
        scoped_type_id,
        decidim_author_type,
        parsed_online_votes,
        parsed_offline_votes,
        parsed_online_votes + parsed_offline_votes AS sum_votes,
        comments_count,
        follows_count,
        concat('https://', (SELECT host FROM {{ ref("organizations")}} org), '/initiatives/i-',decidim_initiatives.id) AS url,
        supports_required,
        decidim_areas.id AS area_id,
        coalesce(nullif(decidim_areas.name::jsonb->>'fr', ''), 'No sub category') AS area_name,
        coalesce(nullif(decidim_area_types.name::jsonb->>'fr',''), 'No category') AS area_type_name,
        'Decidim::Initiative' AS resource_type,
        decidim_initiatives.id::text AS id_as_text
    FROM {{ ref("stg_decidim_initiatives")}} decidim_initiatives
        JOIN {{ ref("organizations")}} decidim_organizations on decidim_organizations.id = decidim_initiatives.decidim_organization_id
        JOIN {{ ref("stg_decidim_initiatives_type_scopes")}} decidim_initiatives_type_scopes on scoped_type_id = decidim_initiatives_type_scopes.id
        LEFT JOIN {{ ref("stg_decidim_areas")}} decidim_areas on decidim_areas.id = decidim_initiatives.decidim_area_id
        LEFT JOIN {{ ref("stg_decidim_area_types")}} decidim_area_types on decidim_area_types.id = area_type_id,
        lateral (SELECT coalesce(nullif(online_votes::jsonb->>'total',''), '0')::int as parsed_online_votes) t_online,
        lateral (SELECT coalesce(nullif(offline_votes::jsonb->>'total',''), '0')::int as parsed_offline_votes) t_offline
