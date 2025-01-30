{% macro translate_first_category_and_sub_category(categories, sub_categories) %}
    {% set lang = env_var('LANG', 'fr') %} -- Default value is 'fr'

    -- Translation for 'Sans catégorie' (fallback for first_category)
    {% if lang == 'fr' %}
        {% set first_category_fallback = 'Sans catégorie' %}
        {% set first_sub_category_fallback = 'Sans sous-catégorie' %}
    {% elif lang == 'de' %}
        {% set first_category_fallback = 'Keine Kategorie' %}
        {% set first_sub_category_fallback = 'Keine Unterkategorie' %}
    {% elif lang == 'en' %}
        {% set first_category_fallback = 'No category' %}
        {% set first_sub_category_fallback = 'No subcategory' %}
    {% elif lang == 'nl' %}
        {% set first_category_fallback = 'Geen categorie' %}
        {% set first_sub_category_fallback = 'Geen subcategorie' %}
    {% else %}
        {% set first_category_fallback = 'Sans catégorie' %}
        {% set first_sub_category_fallback = 'Sans sous-catégorie' %}
    {% endif %}

    -- For translating 'first_category'
    coalesce(
        {% if lang == 'fr' %}
            {{ categories }}[1]
        {% elif lang == 'de' %}
            {{ categories }}[1]
        {% elif lang == 'en' %}
            {{ categories }}[1]
        {% elif lang == 'nl' %}
            {{ categories }}[1]
        {% else %}
            {{ categories }}[1]
        {% endif %}
        , '{{ first_category_fallback }}') AS first_category,

    -- For translating 'first_sub_category'
    coalesce(
        {% if lang == 'fr' %}
            {{ sub_categories }}[1]
        {% elif lang == 'de' %}
            {{ sub_categories }}[1]
        {% elif lang == 'en' %}
            {{ sub_categories }}[1]
        {% elif lang == 'nl' %}
            {{ sub_categories }}[1]
        {% else %}
            {{ sub_categories }}[1]
        {% endif %}
        , '{{ first_sub_category_fallback }}') AS first_sub_category
{% endmacro %}
