{% macro int_meetings_translate_adress(address) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default to French ('fr') if LANG is not set

    (CASE
        WHEN {{ address }} IS NULL THEN
            {% if lang == 'fr' %} 'Pas d''adresse'
            {% elif lang == 'de' %} 'Keine Adresse'
            {% elif lang == 'en' %} 'No adress'
            {% elif lang == 'nl' %} 'Geen adres'
            {% else %}'Unknown'
            {% endif %}
        ELSE {{ address }}
    END)
{% endmacro %}