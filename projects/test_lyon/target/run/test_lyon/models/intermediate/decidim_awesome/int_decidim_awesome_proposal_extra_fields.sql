
  
    

  create  table "test_lyon"."prod"."int_decidim_awesome_proposal_extra_fields__dbt_tmp"
  
  
    as
  
  (
    WITH parsed_data AS (
    SELECT
        decidim_awesome_proposal_extra_fields.id,
        decidim_awesome_proposal_extra_fields.proposal_id,
        xpath('//text()', unnest(xpath('//dt', xml_data)))::text AS private_field_description,
        unnest(xpath('//dd/div/text()', unnest(xpath('//dd', xml_data))))::text AS private_field_content
    FROM
        "test_lyon"."prod"."stg_decidim_awesome_proposal_extra_fields" AS decidim_awesome_proposal_extra_fields,
        LATERAL xmlparse(document private_body_clear) AS xml_data
)
SELECT
    parsed_data.id,
    parsed_data.proposal_id,
    replace(replace(private_field_description, '{"', ''), '"}', '') AS private_field_description,
    parsed_data.private_field_content
FROM
    parsed_data
WHERE
    private_field_content IS NOT NULL
  );
  