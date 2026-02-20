{% macro import_categories_from_taxonomies(type) %}
    SELECT
        (CASE WHEN is_subtaxonomy
            THEN
            array_agg(taxonomy_name)
            ELSE
            array_agg(child_name)
        END) AS categories,
        (CASE WHEN is_subtaxonomy
            THEN
            array_agg(child_name)
            ELSE
            NULL
        END) AS sub_categories,
        taxonomizable_id,
        is_category
    FROM {{ ref("taxonomizations")}} AS taxonomizations
    WHERE taxonomizations.taxonomizable_type = '{{type}}'
    AND is_category
    GROUP BY taxonomizable_id, is_category, is_subtaxonomy
{% endmacro %}
