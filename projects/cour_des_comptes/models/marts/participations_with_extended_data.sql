SELECT
    DISTINCT ON (user_id, ps_title)
    user_id,
    users.age_category AS age_category,
    users.gender AS gender,
    decidim_component_id,
    components.ps_title AS ps_title
FROM {{ ref("participations")}} participations
    JOIN {{ ref("components")}} components ON participations.decidim_component_id = components.id
    JOIN {{ ref("users")}} users ON participations.user_id = users.id