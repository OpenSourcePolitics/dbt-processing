{% macro taxonomizables_select(type) %}
    SELECT
        array_agg(taxonomy_name) AS taxonomies,
        array_agg(child_name) AS sub_taxonomies,
        array_agg(is_scope) AS is_scope,
        taxonomizable_id
    FROM {{ ref("taxonomizations")}} AS taxonomizations
    WHERE taxonomizations.taxonomizable_type = '{{type}}'
    AND is_scope IS FALSE AND is_category IS FALSE
    GROUP BY taxonomizable_id
{% endmacro %}