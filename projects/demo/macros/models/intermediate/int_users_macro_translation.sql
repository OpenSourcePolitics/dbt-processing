{% macro translate_sign_in_count(sign_in_count) %}
{% set lang = env_var('LANG', 'fr') %} -- Default value is 'fr'

(CASE
    WHEN {{ sign_in_count }} = 0 THEN
        {% if lang == 'fr' %}'Jamais'
        {% elif lang == 'de' %}'Nie'
        {% elif lang == 'en' %}'Never'
        {% elif lang == 'nl' %}'Nooit'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} = 1 THEN
        {% if lang == 'fr' %}'Une seule fois'
        {% elif lang == 'de' %}'Einmal'
        {% elif lang == 'en' %}'Once'
        {% elif lang == 'nl' %}'Eén keer'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} = 2 THEN
        {% if lang == 'fr' %}'Deux fois'
        {% elif lang == 'de' %}'Zweimal'
        {% elif lang == 'en' %}'Twice'
        {% elif lang == 'nl' %}'Twee keer'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} BETWEEN 2 AND 10 THEN
        {% if lang == 'fr' %}'Entre 2 et 10 fois'
        {% elif lang == 'de' %}'Zwischen 2 und 10 Mal'
        {% elif lang == 'en' %}'Between 2 and 10 times'
        {% elif lang == 'nl' %}'Tussen 2 en 10 keer'
        {% else %}'Unknown'
        {% endif %}
    ELSE
        {% if lang == 'fr' %}'Plus de 10 fois'
        {% elif lang == 'de' %}'Mehr als 10 Mal'
        {% elif lang == 'en' %}'More than 10 times'
        {% elif lang == 'nl' %}'Meer dan 10 keer'
        {% else %}'Unknown'
        {% endif %}
END)
{% endmacro %}
