{% macro get_column_if_exists(relation, column_name, cast_type="TEXT", default_value="NULL") %}
  {% set columns = adapter.get_columns_in_relation(relation) %}
  {% if column_name in columns | map(attribute="name") %}
    {{ column_name }}
  {% else %}
    {% if cast_type %}
      CAST({{ default_value }} AS {{ cast_type }}) AS {{ column_name }}
    {% endif %}
  {% endif %}
{% endmacro %}

