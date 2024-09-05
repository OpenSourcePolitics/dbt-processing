    SELECT
        decidim_initiatives_votes.id,
        decidim_initiative_id,
        decidim_initiatives_votes.decidim_author_id,
        decidim_initiatives_votes.created_at,
        hash_id, 
        decidim_scope_id,
        decidim_initiatives.url AS initiative_url
    FROM decidim_initiatives_votes
        JOIN {{ ref("initiatives")}} AS decidim_initiatives on decidim_initiatives.id = decidim_initiative_id
