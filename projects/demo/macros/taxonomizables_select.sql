{% macro taxonomizables_select(type) %}
    SELECT
        array_agg(taxonomy_name) AS taxonomies,
        array_agg(child_name) AS sub_taxonomies,
        taxonomizable_id
    FROM {{ ref("taxonomizations")}} AS taxonomizations
    WHERE taxonomizations.taxonomizable_type = '{{type}}'
    GROUP BY taxonomizable_id
{% endmacro %}