{% macro coalesce_legacy_and_new_columns(relation, legacy_column_name, new_column_name) %}
  {% set columns = adapter.get_columns_in_relation(relation) %}
  {% set column_names = columns | map(attribute="name") %}

  {% if legacy_column_name in column_names %}
      {{ legacy_column_name }}
  {% else %}
      {{ new_column_name }} AS {{ legacy_column_name }}
  {% endif %}

{% endmacro %}