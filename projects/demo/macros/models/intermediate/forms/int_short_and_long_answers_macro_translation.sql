{% macro int_forms_translate_short_and_long_answers(answer_body) %}
    {% set lang = var('DBT_LANG', 'fr') %} -- Default language is 'fr'

    {% set translations = {
        'fr': "Pas de réponse",
        'en': "No answer",
        'de': "Keine Antwort",
        'nl': "Geen antwoord"
    } %}

    COALESCE(NULLIF({{ answer_body }}, ''), '{{ translations.get(lang, "Unknown") }}')
{% endmacro %}