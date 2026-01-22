WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_meetings_registrations') }}
),
renamed AS (
    select
        id,
        decidim_user_id,
        decidim_meeting_id,
        created_at,
        updated_at,
        code,
        {{ get_column_if_exists(source('decidim', 'decidim_meetings_registrations'), 'status', 'TEXT', 'registered') }},
        validated_at,
        decidim_user_group_id
    FROM source
)
select * FROM renamed
  