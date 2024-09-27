SELECT
    DISTINCT ON (user_id, ps_title)
    user_id,
    users.age_category AS age_category,
    decidim_component_id,
    components.ps_title AS ps_title
FROM "test_lyon"."prod"."participations" participations
    JOIN "test_lyon"."prod"."components" components ON participations.decidim_component_id = components.id
    JOIN "test_lyon"."prod"."users" users ON participations.user_id = users.id