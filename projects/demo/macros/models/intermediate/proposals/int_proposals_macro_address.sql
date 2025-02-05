{% macro int_proposals_macro_address(column_name) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default language is 'fr'

    {% set translations = {
        'fr': "Pas d'adresse",
        'en': "No address",
        'de': "Keine Adresse",
        'nl': "Geen adres"
    } %}

    COALESCE(
        NULLIF({{ column_name }}, ''),
        '{{ translations.get(lang, "Unknown") | replace("'", "''") }}'
    )
{% endmacro %}