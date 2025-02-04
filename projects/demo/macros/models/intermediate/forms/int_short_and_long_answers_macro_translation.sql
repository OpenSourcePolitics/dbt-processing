{% macro int_forms_translate_short_and_long_answers(answer_body) %}
{% set lang = env_var('DBT_LANG', 'fr') %} -- Default value is 'fr'

COALESCE(
    NULLIF({{ answer_body }}, ''),
    {% if lang == 'fr' %}'Pas de réponse'
    {% elif lang == 'de' %}'Keine Antwort'
    {% elif lang == 'en' %}'No answer'
    {% elif lang == 'nl' %}'Geen antwoord'
    {% else %}'Unknown'
    {% endif %}
)
{% endmacro %}
