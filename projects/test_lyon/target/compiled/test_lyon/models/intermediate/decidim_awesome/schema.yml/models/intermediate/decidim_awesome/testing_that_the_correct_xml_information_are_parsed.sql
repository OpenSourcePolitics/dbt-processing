WITH  __dbt__cte__stg_decidim_awesome_proposal_extra_fields as (

-- Fixture for stg_decidim_awesome_proposal_extra_fields
select 
    
    cast(1 as bigint)
 as id, 
    
    cast(101 as bigint)
 as proposal_id, cast(null as timestamp without time zone) as updated_at, cast(null as timestamp without time zone) as created_at, 
    
    cast('<xml><dl class="decidim_awesome-custom_fields" data-generator="decidim_awesome" data-version="0.10.3"><dt name="radio-group-1725003392539-0">Cette idée est déposée à titre :</dt><dd id="radio-group-1725003392539-0" name="radio-group"><div alt="individuel">Individuel</div></dd><dt name="radio-group-1725003468065-0">Votre tranche d''âge :</dt><dd id="radio-group-1725003468065-0" name="radio-group"><div alt="1625">16-25 ans</div></dd></dl></xml>' as text)
 as private_body_clear
), parsed_data AS (
    SELECT
        decidim_awesome_proposal_extra_fields.id,
        decidim_awesome_proposal_extra_fields.proposal_id,
        xpath('//text()', unnest(xpath('//dt', xml_data)))::text AS private_field_description,
        unnest(xpath('//dd/div/text()', unnest(xpath('//dd', xml_data))))::text AS private_field_content
    FROM
        __dbt__cte__stg_decidim_awesome_proposal_extra_fields AS decidim_awesome_proposal_extra_fields,
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