{% macro categorizations_filter(type) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default language is 'fr'

    WITH categorizations AS (
        SELECT 
            array_agg(category_name) AS categories,
            array_agg(child_name) AS sub_categories,
            categorizable_id
        FROM {{ ref("categorizations")}} AS categorizations
        WHERE categorizations.categorizable_type = '{{type}}'
        GROUP BY categorizable_id
    )
    SELECT 
        categorizations.categorizable_id,
        categorizations.categories,
        categorizations.sub_categories,
        COALESCE(
            NULLIF(categorizations.categories[1], ''), 
            {% if lang == 'fr' %}'Sans catégorie'
            {% elif lang == 'de' %} 'Keine Kategorie'
            {% elif lang == 'en' %} 'No category'
            {% elif lang == 'nl' %} 'Geen categorie'
            {% else %} 'Unknown' 
            {% endif %}
        ) AS first_category,
        COALESCE(
            NULLIF(categorizations.sub_categories[1], ''), 
            {% if lang == 'fr' %}'Sans sous-catégorie'
            {% elif lang == 'de' %} 'Keine Unterkategorie'
            {% elif lang == 'en' %} 'No subcategory'
            {% elif lang == 'nl' %} 'Geen subcategorie'
            {% else %} 'Unknown' 
            {% endif %}
        ) AS first_sub_category 
    FROM categorizations
{% endmacro %}
