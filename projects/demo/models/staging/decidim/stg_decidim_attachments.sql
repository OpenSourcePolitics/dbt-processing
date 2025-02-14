SELECT
    id,
    title,
    description,
    file,
    content_type,
    file_size,
    attached_to_id,
    created_at,
    updated_at,
    attached_to_type,
    weight,
    attachment_collection_id,
    {{ get_column_if_exists(source('decidim', 'decidim_attachments'), 'link', 'TEXT') }}
FROM {{ source('decidim', 'decidim_attachments') }}