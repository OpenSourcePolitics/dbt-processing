{% macro get_column_if_exists(relation, column_name, cast_type="TEXT", default_value="NULL", include_alias=True) %}
  {% set columns = adapter.get_columns_in_relation(relation) %}
  {% set column_names = columns | map(attribute="name") %}

  {% if column_name in column_names %}
    {{ column_name }}
  {% else %}
    {% if include_alias %}
      CAST({{ default_value }} AS {{ cast_type }}) AS {{ column_name }}
    {% else %}
      CAST({{ default_value }} AS {{ cast_type }})
    {% endif %}
  {% endif %}
{% endmacro %}
