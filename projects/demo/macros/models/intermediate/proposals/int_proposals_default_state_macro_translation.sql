{% macro int_proposals_translate_default_state(proposal_state) %}
    {% set lang = env_var('DBT_LANG', 'fr') %}  -- Default to French ('fr') if LANG is not set

    (CASE
        WHEN {{ proposal_state }} IS NULL THEN
            {% if lang == 'fr' %} 'Pas d''état'
            {% elif lang == 'de' %} 'Kein Zustand'
            {% elif lang == 'en' %} 'No state'
            {% elif lang == 'nl' %} 'Geen status'
            {% else %}'Unknown'
            {% endif %}
        ELSE {{ proposal_state }}
    END)
{% endmacro %}
