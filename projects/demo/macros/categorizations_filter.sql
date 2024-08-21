{% macro categorizations_filter(type) %}
    SELECT 
        array_agg(category_name) AS categories,
        array_agg(child_name) AS sub_categories,
        categorizable_id
    FROM {{ ref("categorizations")}} AS categorizations
    WHERE categorizations.categorizable_type = '{{type}}'
    GROUP BY categorizable_id 
{% endmacro %}
