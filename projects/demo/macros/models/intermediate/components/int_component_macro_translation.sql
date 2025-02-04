{% macro int_component_translate_manifest_name(manifest_name) %}
{% set lang = var('DBT_LANG', 'fr') %} -- Default value is 'fr'

(CASE
    WHEN {{ manifest_name }} = 'accountability' THEN
        {% if lang == 'fr' %}'Suivi'
        {% elif lang == 'de' %}'Nachverfolgung'
        {% elif lang == 'en' %}'Accountability'
        {% elif lang == 'nl' %}'Verantwoording'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ manifest_name }} = 'pages' THEN
        {% if lang == 'fr' %}'Pages'
        {% elif lang == 'de' %}'Seite'
        {% elif lang == 'en' %}'Pages'
        {% elif lang == 'nl' %}'Pagina'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ manifest_name }} = 'budgets' THEN
        {% if lang == 'fr' %}'Budgets'
        {% elif lang == 'de' %}'Budgets'
        {% elif lang == 'en' %}'Budgets'
        {% elif lang == 'nl' %}'Budgetten'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ manifest_name }} = 'meetings' THEN
        {% if lang == 'fr' %}'Rencontres'
        {% elif lang == 'de' %}'Sitzungen'
        {% elif lang == 'en' %}'Meetings'
        {% elif lang == 'nl' %}'Vergaderingen'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ manifest_name }} = 'proposals' THEN
        {% if lang == 'fr' %}'Propositions'
        {% elif lang == 'de' %}'Vorschläge'
        {% elif lang == 'en' %}'Proposals'
        {% elif lang == 'nl' %}'Voorstellen'
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ manifest_name }} = 'surveys' THEN
        {% if lang == 'fr' %}'Enquêtes'
        {% elif lang == 'de' %}'Umfragen'
        {% elif lang == 'en' %}'Surveys'
        {% elif lang == 'nl' %}'Enquêtes'
        {% else %}'Unknown'
        {% endif %}
    ELSE
        {% if lang == 'fr' %}'Blogs'
        {% elif lang == 'de' %}'Blogs'
        {% elif lang == 'en' %}'Blogs'
        {% elif lang == 'nl' %}'Blogs'
        {% else %}'Unknown'
        {% endif %}
END)
{% endmacro %}
