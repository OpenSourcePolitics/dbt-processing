{% macro date_check(date_of_birth) %}
    CASE
        WHEN {{ date_of_birth }} ~ '\d{1,2}\/\d{1,2}\/\d{4}'
         AND split_part({{ date_of_birth }}, '/', 3)::int BETWEEN 1900 AND 2100
        THEN TO_DATE({{ date_of_birth }}, 'DD/MM/YYYY')
        WHEN {{ date_of_birth }} ~ '^\d{4}-\d{2}-\d{2}$'
         AND split_part({{ date_of_birth }}, '-', 1)::int BETWEEN 1900 AND 2100
        THEN {{ date_of_birth }}::DATE
        ELSE
        NULL
    END
{% endmacro %}