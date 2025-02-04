{% macro int_meetings_translate_type_of_meeting(meeting_type) %}
{% set lang = env_var('DBT_LANG', 'fr') %} -- Default value is 'fr'

(CASE {{ meeting_type }}
    WHEN 'online' THEN
        {% if lang == 'fr' %}'En ligne'
        {% elif lang == 'de' %}'Online'
        {% elif lang == 'en' %}'Online'
        {% elif lang == 'nl' %}'Online'
        {% else %}'Unknown'
        {% endif %}
    WHEN 'in_person' THEN
        {% if lang == 'fr' %}'En présentiel'
        {% elif lang == 'de' %}'Vor Ort'
        {% elif lang == 'en' %}'In person'
        {% elif lang == 'nl' %}'Fysiek'
        {% else %}'Unknown'
        {% endif %}
    WHEN 'hybrid' THEN
        {% if lang == 'fr' %}'Hybride'
        {% elif lang == 'de' %}'Hybrid'
        {% elif lang == 'en' %}'Hybrid'
        {% elif lang == 'nl' %}'Hybride'
        {% else %}'Unknown'
        {% endif %}
    ELSE {{ meeting_type }} 
END)
{% endmacro %}
