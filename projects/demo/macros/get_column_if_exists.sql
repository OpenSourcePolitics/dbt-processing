{% macro get_column_if_exists(relation, column_name, default_value="NULL") %}
  {% set columns = adapter.get_columns_in_relation(relation) %}
  {% if column_name in columns | map(attribute="name") %}
    {{ column_name }}
  {% else %}
    {{ default_value }} AS {{ column_name }}
  {% endif %}
{% endmacro %}
