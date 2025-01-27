{% macro translate_sign_in_count(sign_in_count) %}
(CASE
    WHEN {{ sign_in_count }} = 0 THEN
        {% if env_var('LANG') == 'fr' %}'Jamais'
        {% elif env_var('LANG') == 'de' %}'Nie'
        {% elif env_var('LANG') == 'en' %}'Never'
        {% elif env_var('LANG') == 'nl' %}'Nooit'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} = 1 THEN
        {% if env_var('LANG') == 'fr' %}'Une seule fois'
        {% elif env_var('LANG') == 'de' %}'Einmal'
        {% elif env_var('LANG') == 'en' %}'Once'
        {% elif env_var('LANG') == 'nl' %}'Eén keer'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} = 2 THEN
        {% if env_var('LANG') == 'fr' %}'Deux fois'
        {% elif env_var('LANG') == 'de' %}'Zweimal'
        {% elif env_var('LANG') == 'en' %}'Twice'
        {% elif env_var('LANG') == 'nl' %}'Twee keer'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ sign_in_count }} BETWEEN 2 AND 10 THEN
        {% if env_var('LANG') == 'fr' %}'Entre 2 et 10 fois'
        {% elif env_var('LANG') == 'de' %}'Zwischen 2 und 10 Mal'
        {% elif env_var('LANG') == 'en' %}'Between 2 and 10 times'
        {% elif env_var('LANG') == 'nl' %}'Tussen 2 en 10 keer'
        {% else %}'Unknown'
        {% endif %}
    ELSE
        {% if env_var('LANG') == 'fr' %}'Plus de 10 fois'
        {% elif env_var('LANG') == 'de' %}'Mehr als 10 Mal'
        {% elif env_var('LANG') == 'en' %}'More than 10 times'
        {% elif env_var('LANG') == 'nl' %}'Meer dan 10 keer'
        {% else %}'Unknown'
        {% endif %}
END)
{% endmacro %}
