SELECT 
    decidim_attachments.id,
    decidim_attachments.file,
    decidim_attachments.attached_to_id,
    decidim_attachments.attached_to_type,
    concat('https://',(SELECT host FROM {{ ref("organizations")}} organization), '/uploads/decidim/attachment/file/', decidim_attachments.id, '/', decidim_attachments.file) AS url
FROM {{ ref ("stg_decidim_attachments")}} AS decidim_attachments