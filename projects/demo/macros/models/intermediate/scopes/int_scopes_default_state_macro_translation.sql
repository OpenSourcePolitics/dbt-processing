{% macro int_scopes_default_name(scope_name) %}
{% set lang = env_var('LANG', 'fr') %} -- Default value is 'fr'

COALESCE(
    NULLIF({{ scope_name }}, ''),
    {% if lang == 'fr' %}'Sans secteur'
    {% elif lang == 'de' %}'Kein Bereich'
    {% elif lang == 'en' %}'No sector'
    {% elif lang == 'nl' %}'Geen sector'
    {% else %}'Unknown'
    {% endif %}
)
{% endmacro %}
