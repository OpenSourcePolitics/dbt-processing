{% macro import_scopes_from_taxonomies(type) %}
    SELECT
        child_name,
        taxonomizable_id,
        is_scope
    FROM {{ ref("taxonomizations")}} AS taxonomizations
    WHERE taxonomizations.taxonomizable_type = '{{type}}'
    AND is_scope
{% endmacro %}