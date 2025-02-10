{% macro age_category(age) %}
    (CASE
        WHEN {{ age }} < 15 THEN '[0-15 ans]'
        WHEN {{ age }} >= 15 AND {{ age }} <= 19 THEN '[15-19 ans]'
        WHEN {{ age }} >= 20 AND {{ age }} <= 24 THEN '[20-24 ans]'
        WHEN {{ age }} >= 25 AND {{ age }} <= 29 THEN '[25-29 ans]'
        WHEN {{ age }} >= 30 AND {{ age }} <= 34 THEN '[30-34 ans]'
        WHEN {{ age }} >= 35 AND {{ age }} <= 39 THEN '[35-39 ans]'
        WHEN {{ age }} >= 40 AND {{ age }} <= 44 THEN '[40-44 ans]'
        WHEN {{ age }} >= 45 AND {{ age }} <= 49 THEN '[45-49 ans]'
        WHEN {{ age }} >= 50 AND {{ age }} <= 54 THEN '[50-54 ans]'
        WHEN {{ age }} >= 55 AND {{ age }} <= 59 THEN '[55-59 ans]'
        WHEN {{ age }} >= 60 AND {{ age }} <= 64 THEN '[60-64 ans]'
        WHEN {{ age }} >= 65 AND {{ age }} <= 69 THEN '[65-69 ans]'
        WHEN {{ age }} >= 70 AND {{ age }} <= 74 THEN '[70-74 ans]'
        WHEN {{ age }} >= 75 THEN '[75 ans ou plus]'
        ELSE 'Âge non défini'
    END) 
{% endmacro %}
