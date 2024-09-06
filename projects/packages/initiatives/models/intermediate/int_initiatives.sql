    SELECT
        decidim_initiatives.id,
        title::jsonb->>'fr' AS title,
        regexp_replace(decidim_initiatives.description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS description,
        decidim_organization_id,
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
        decidim_area_id,
        comments_count,
        follows_count,
        concat('https://', (SELECT host FROM {{ ref("organizations")}} org), '/initiatives/i-',decidim_initiatives.id) AS url,
        'Decidim::Initiative' AS resource_type,
        decidim_initiatives.id::text AS id_as_text
    FROM {{ ref("stg_decidim_initiatives")}} decidim_initiatives,
        lateral (SELECT coalesce(nullif(online_votes::jsonb->>'total',''), '0')::int as parsed_online_votes) t_online,
        lateral (SELECT coalesce(nullif(offline_votes::jsonb->>'total',''), '0')::int as parsed_offline_votes) t_offline
