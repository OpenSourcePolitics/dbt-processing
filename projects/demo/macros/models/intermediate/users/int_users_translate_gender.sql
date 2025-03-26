{% macro translate_gender(gender) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Default to French ('fr') if LANG is not set

(CASE
    WHEN {{ gender }} = 'male' THEN
        {% if lang == 'fr' %} 'Homme'
        {% elif lang == 'de' %} 'Männlich'
        {% elif lang == 'nl' %} 'Man'
        {% else %} 'Male'  
        {% endif %}
    WHEN {{ gender }} = 'female' THEN
        {% if lang == 'fr' %} 'Femme'
        {% elif lang == 'de' %} 'Weiblich'
        {% elif lang == 'nl' %} 'Vrouw'
        {% else %} 'Female'  
        {% endif %}
    WHEN {{ gender }} = 'other' THEN
        {% if lang == 'fr' %} 'Autre'
        {% elif lang == 'de' %} 'Andere'
        {% elif lang == 'nl' %} 'Anders'
        {% else %} 'Other'  
        {% endif %}
    ELSE
        {% if lang == 'fr' %} 'Inconnu'
        {% elif lang == 'de' %} 'Unbekannt'
        {% elif lang == 'nl' %} 'Onbekend'
        {% else %} 'Unknown'  
        {% endif %}
    END)
{% endmacro %}
