{% macro stg_meetings_get_type_of_meeting(relation) %}
  {% if check_column_type(relation, 'type_of_meeting', 'bigint') %}
    (CASE
        WHEN type_of_meeting = 0 THEN 'in_person'
        WHEN type_of_meeting = 10 THEN 'online'
        WHEN type_of_meeting = 20 THEN 'hybrid'
        ELSE 'unknown'
     END) AS type_of_meeting
  {% else %}
    type_of_meeting
  {% endif %}
{% endmacro %}
