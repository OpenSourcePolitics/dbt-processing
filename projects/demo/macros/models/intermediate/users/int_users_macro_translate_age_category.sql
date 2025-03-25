{% macro translate_age_category(age_category) %}
{% set lang = var('DBT_LANG', 'fr') %} -- Default value is 'fr'

(CASE
    WHEN {{ age_category }} = '0-15 ans' THEN
        {% if lang == 'fr' %} '0-15 ans'
        {% elif lang == 'de' %} ''
        {% elif lang == 'nl' %} ''
        {% else %} ''  
        {% endif %}
    WHEN {{ age }} >= 15 AND {{ age }} <= 19 THEN '[15-19 ans]'
        {% if lang == 'fr' %} '15-19 ans'
        {% elif lang == 'de' %} ''
        {% elif lang == 'nl' %} ''
        {% else %} ''  
        {% endif %}
    ELSE
        {% if lang == 'fr' %} 'Âge non défini'
        {% elif lang == 'de' %} ''
        {% elif lang == 'nl' %} ''
        {% else %} 'Age undefined'  
        {% endif %}
    END) 
{% endmacro %}