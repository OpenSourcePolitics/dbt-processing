{% macro int_forms_answers_translate_author_status(decidim_user_id) %}
{% set lang = var('DBT_LANG', 'fr') %} -- Default value is 'fr'

(CASE
    WHEN {{ decidim_user_id }} IS NULL THEN
        {% if lang == 'fr' %}'Non connecté'
        {% elif lang == 'de' %}'Abgemeldet'
        {% elif lang == 'en' %}'Logged out'
        {% elif lang == 'nl' %}'Uitgelogd'
        {% else %}'Unknown'
        {% endif %}
     
    ELSE
        {% if lang == 'fr' %}'Inscrit et connecté'
        {% elif lang == 'de' %}'Registriert und eingeloggt'
        {% elif lang == 'en' %}'Registered and logged in'
        {% elif lang == 'nl' %}'Geregistreerd en ingelogd'
        {% else %}'Unknown'
        {% endif %}
    END)
{% endmacro %}
