{% macro check_column_type(relation, column_name, expected_dtype) %}
  {% set columns = adapter.get_columns_in_relation(relation) %}

  {% set result = {'is_correct_type': False} %}

  {% for column in columns %}
    {% if column.column == column_name %}
      {% if column.dtype == expected_dtype %}
        {% do result.update({'is_correct_type': True}) %}
      {% endif %}
    {% endif %}
  {% endfor %}

  {{ return(result.is_correct_type) }}
{% endmacro %}
