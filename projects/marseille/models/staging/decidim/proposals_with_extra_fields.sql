WITH json_extracted AS (
    -- Step 1: Extract the 'fr' key from the JSON column
    SELECT
        id,
        json_extract_path_text(body::json, 'fr') AS raw_xml_content
    FROM
        public.decidim_proposals_proposals
),
cleaned_content AS (
    -- Step 2: Clean and encapsulate the extracted XML content in a root element
    SELECT
        id,
        '<root>' || -- Add a root element to encapsulate the XML
        regexp_replace(
            regexp_replace(
                regexp_replace(
                    raw_xml_content,
                    '&nbsp;', ' ', 'g' -- Replace '&nbsp;' with a space
                ),
                '<(br|img)([^>]*)>', '<\1\2 />', 'gi' -- Ensure <br> and <img> tags are self-closing
            ),
            '</?(p|br|img)([^>]*)>', '', 'gi' -- Remove malformed or unnecessary <p>, <br>, and <img> tags
        ) || '</root>' AS cleaned_xml_content -- Close the root element
    FROM
        json_extracted
),
parsed_data AS (
    -- Step 3: Parse the cleaned XML content and extract the desired fields
    SELECT
        cleaned_content.id,
        xpath('//text()', unnest(xpath('//dt', xml_data)))::text AS field_description, -- Extract field descriptions from <dt>
        unnest(xpath('//dd/div/text()', unnest(xpath('//dd', xml_data))))::text AS field_content -- Extract field values from <dd><div>
    FROM
        cleaned_content,
        LATERAL xmlparse(document cleaned_xml_content) AS xml_data -- Parse the cleaned XML content
)
-- Step 4: Final selection of parsed fields with cleaning of the description
SELECT
    parsed_data.id,
    replace(replace(field_description, '{"', ''), '"}', '') AS field_description, -- Clean up description
    parsed_data.field_content -- Extracted field content
FROM
    parsed_data
WHERE
    field_content IS NOT NULL -- Filter out rows with null field content