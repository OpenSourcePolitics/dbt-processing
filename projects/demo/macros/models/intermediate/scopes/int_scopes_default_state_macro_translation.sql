{% macro int_scopes_default_name(scope_name) %}
    {% set lang = var('DBT_LANG', 'fr') %} -- Default language is 'fr'

    {% set translations = {
        'fr': "Sans secteur",
        'en': "No sector",
        'de': "Kein Bereich",
        'nl': "Geen sector"
    } %}

    COALESCE(NULLIF({{ scope_name }}, ''), '{{ translations.get(lang, "Unknown") }}')
{% endmacro %}
