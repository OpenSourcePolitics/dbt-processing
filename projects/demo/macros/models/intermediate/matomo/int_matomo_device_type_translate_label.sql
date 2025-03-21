{% macro int_matomo_device_type_translate_label(label) %}
    {% set lang = var('DBT_LANG', 'fr') %}  -- Langue par défaut = français

    (CASE
        WHEN {{ label }} IS NULL THEN
            {% if lang == 'fr' %} 'Inconnu'
            {% elif lang == 'de' %} 'Unbekannt'
            {% elif lang == 'en' %} 'Unknown'
            {% elif lang == 'nl' %} 'Onbekend'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Téléphone intelligent (smartphone)' THEN
            {% if lang == 'fr' %} 'Téléphone intelligent (smartphone)'
            {% elif lang == 'de' %} 'Smartphone'
            {% elif lang == 'en' %} 'Smartphone'
            {% elif lang == 'nl' %} 'Smartphone'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Bureau' THEN
            {% if lang == 'fr' %} 'Bureau'
            {% elif lang == 'de' %} 'Desktop'
            {% elif lang == 'en' %} 'Desktop'
            {% elif lang == 'nl' %} 'Desktop'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Phablette' THEN
            {% if lang == 'fr' %} 'Phablette'
            {% elif lang == 'de' %} 'Phablet'
            {% elif lang == 'en' %} 'Phablet'
            {% elif lang == 'nl' %} 'Phablet'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Tablette' THEN
            {% if lang == 'fr' %} 'Tablette'
            {% elif lang == 'de' %} 'Tablet'
            {% elif lang == 'en' %} 'Tablet'
            {% elif lang == 'nl' %} 'Tablet'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Lecteur de medias portable' THEN
            {% if lang == 'fr' %} 'Lecteur de medias portable'
            {% elif lang == 'de' %} 'Portable Mediengeräte'
            {% elif lang == 'en' %} 'Portable media player'
            {% elif lang == 'nl' %} 'Draagbare mediaspeler'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'TV' THEN
            {% if lang == 'fr' %} 'TV'
            {% elif lang == 'de' %} 'TV'
            {% elif lang == 'en' %} 'Tv'
            {% elif lang == 'nl' %} 'TV'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Affichage intelligent' THEN
            {% if lang == 'fr' %} 'Affichage intelligent'
            {% elif lang == 'de' %} 'Smart Display'
            {% elif lang == 'en' %} 'Smart display'
            {% elif lang == 'nl' %} 'Slim scherm'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Caméra' THEN
            {% if lang == 'fr' %} 'Caméra'
            {% elif lang == 'de' %} 'Digitalkamera'
            {% elif lang == 'en' %} 'Camera'
            {% elif lang == 'nl' %} 'Camera'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Console' THEN
            {% if lang == 'fr' %} 'Console'
            {% elif lang == 'de' %} 'Spielekonsole'
            {% elif lang == 'en' %} 'Console'
            {% elif lang == 'nl' %} 'Console'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Fonctionnalité téléphone' THEN
            {% if lang == 'fr' %} 'Fonctionnalité téléphone'
            {% elif lang == 'de' %} 'Feature-Phone'
            {% elif lang == 'en' %} 'Feature phone'
            {% elif lang == 'nl' %} 'Toekomstige telefoon'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Haut-parleur intelligent' THEN
            {% if lang == 'fr' %} 'Haut-parleur intelligent'
            {% elif lang == 'de' %} 'Smarter Lautsprecher'
            {% elif lang == 'en' %} 'Smart speaker'
            {% elif lang == 'nl' %} 'Slimme luidspreker'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Navigateur de voiture' THEN
            {% if lang == 'fr' %} 'Navigateur de voiture'
            {% elif lang == 'de' %} 'PKW-Browser'
            {% elif lang == 'en' %} 'Car browser'
            {% elif lang == 'nl' %} 'Auto browser'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Périphérique' THEN
            {% if lang == 'fr' %} 'Périphérique'
            {% elif lang == 'de' %} 'Peripheriegeräte'
            {% elif lang == 'en' %} 'Peripheral'
            {% elif lang == 'nl' %} 'Randapparatuur'
            {% else %} 'Unknown'
            {% endif %}
        WHEN {{ label }} = 'Portable' THEN
            {% if lang == 'fr' %} 'Portable'
            {% elif lang == 'de' %} 'Tragbare Geräte'
            {% elif lang == 'en' %} 'Wearable'
            {% elif lang == 'nl' %} 'Draagbaar'
            {% else %} 'Unknown'
            {% endif %}
        ELSE 'Unknown'
    END)
{% endmacro %}
