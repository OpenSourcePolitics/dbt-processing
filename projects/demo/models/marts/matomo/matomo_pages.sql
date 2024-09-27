SELECT *,
	case
        when label similar to '/(processes|assemblies)/%' then split_part(split_part(label, '/', 3), '?', 1)
		else ''
		end AS slug,
	case
	    when label similar to '/(processes|assemblies)/%/%/f/[0-9]*/%' then null --remove non-int garbage data
	    when label similar to '/(processes|assemblies)/%/f/[0-9]*/%' then split_part(split_part(label, '/', 5), '?', 1)::int
		else null
		end as component_id
FROM {{ref ("stg_matomo_pages")}}