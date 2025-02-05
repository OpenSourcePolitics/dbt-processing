{% macro categorization_first_category(column_name) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default language is 'fr'

    {% set translations = {
        'fr': "Sans catégorie",
        'en': "No category",
        'de': "Keine Kategorie",
        'nl': "Geen categorie"
    } %}

    COALESCE(NULLIF({{ column_name }}, ''), '{{ translations.get(lang, "Unknown") }}') AS first_category
{% endmacro %}

{% macro categorization_first_sub_category(column_name) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default language is 'fr'

    {% set translations = {
        'fr': "Sans sous-catégorie",
        'en': "No subcategory",
        'de': "Keine Unterkategorie",
        'nl': "Geen subcategorie"
    } %}

    COALESCE(NULLIF({{ column_name }}, ''), '{{ translations.get(lang, "Unknown") }}') AS first_sub_category
{% endmacro %}