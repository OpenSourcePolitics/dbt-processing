{% macro translate_renamed_label(label) %}
    {% set lang = env_var('LANG', 'fr') %} -- Default value is 'fr'

    -- Translation for different languages
    CASE 
        WHEN {{ label }} = 'Mot clef indéfini' THEN 
            {% if lang == 'fr' %}
                'Moteur de recherche'
            {% elif lang == 'de' %}
                'Suchmaschine'
            {% elif lang == 'en' %}
                'Search engine'
            {% elif lang == 'nl' %}
                'Zoekmachine'
            {% else %}
                'Moteur de recherche'  -- default to French
            {% endif %}
        ELSE {{ label }}
    END
{% endmacro %}
