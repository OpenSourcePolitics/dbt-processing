{% macro int_matomo_referrers_translate_sub_type(sub_type) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Langue par défaut = français

    (CASE
        WHEN {{ sub_type }} IS NULL THEN
            {% if lang == 'fr' %} 'Inconnu'
            {% elif lang == 'de' %} 'Unbekannt'
            {% elif lang == 'en' %} 'Unknown'
            {% elif lang == 'nl' %} 'Onbekend'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ sub_type }} = 'Campagnes' THEN
            {% if lang == 'fr' %} 'Campagnes'
            {% elif lang == 'de' %} 'Kampagnen'
            {% elif lang == 'en' %} 'Campaigns'
            {% elif lang == 'nl' %} 'Campagnes'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ sub_type }} = 'Sites web' THEN
            {% if lang == 'fr' %} 'Sites web'
            {% elif lang == 'de' %} 'Websites'
            {% elif lang == 'en' %} 'Websites'
            {% elif lang == 'nl' %} 'Websites'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ sub_type }} = 'Moteurs de recherche' THEN
            {% if lang == 'fr' %} 'Moteurs de recherche'
            {% elif lang == 'de' %} 'Suchmaschinen'
            {% elif lang == 'en' %} 'Search engines'
            {% elif lang == 'nl' %} 'Zoekmachines'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ sub_type }} = 'Réseaux sociaux' THEN
            {% if lang == 'fr' %} 'Réseaux sociaux'
            {% elif lang == 'de' %} 'Soziale Netzwerke'
            {% elif lang == 'en' %} 'Social networks'
            {% elif lang == 'nl' %} 'Sociale netwerken'
            {% else %} 'Unknown'
            {% endif %}
        ELSE 'Unknown'
    END)
{% endmacro %}
