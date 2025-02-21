{% macro get_name_column(lang='fr') %}
    CASE
      WHEN name ~ '^\s*\{.*\}\s*$' THEN (CAST(name AS jsonb)->>'{{ lang }}')
      ELSE name
    END AS name
{% endmacro %}
