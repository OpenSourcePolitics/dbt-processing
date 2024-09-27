
-- Fixture for stg_decidim_awesome_proposal_extra_fields
select 
    
    cast(1 as bigint)
 as id, 
    
    cast(101 as bigint)
 as proposal_id, cast(null as timestamp without time zone) as updated_at, cast(null as timestamp without time zone) as created_at, 
    
    cast('<xml><dl class="decidim_awesome-custom_fields" data-generator="decidim_awesome" data-version="0.10.3"><dt name="radio-group-1725003392539-0">Cette idée est déposée à titre :</dt><dd id="radio-group-1725003392539-0" name="radio-group"><div alt="individuel">Individuel</div></dd><dt name="radio-group-1725003468065-0">Votre tranche d''âge :</dt><dd id="radio-group-1725003468065-0" name="radio-group"><div alt="1625">16-25 ans</div></dd></dl></xml>' as text)
 as private_body_clear