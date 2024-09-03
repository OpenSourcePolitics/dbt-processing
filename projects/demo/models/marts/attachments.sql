WITH org AS (
    -- Assumption: There is only one organization, so we select the first available host
    SELECT host
    FROM {{ ref("organizations") }}
    LIMIT 1
)
SELECT
    decidim_attachments.id,
    decidim_attachments.file,
    decidim_attachments.attached_to_id,
    decidim_attachments.attached_to_type,
    concat('https://', org.host, '/uploads/decidim/attachment/file/', decidim_attachments.id, '/', decidim_attachments.file) AS url
FROM
    {{ ref("stg_decidim_attachments") }} AS decidim_attachments
CROSS JOIN org