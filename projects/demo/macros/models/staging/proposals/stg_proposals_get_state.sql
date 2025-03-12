{% macro stg_proposals_get_state(relation) %}
  {% if check_column_type(relation, 'old_state', 'bigint') %}
    (CASE
        WHEN old_state = 0 THEN 'not_answered'
        WHEN old_state = 10 THEN 'evaluating'
        WHEN old_state = 20 THEN 'accepted'
        WHEN old_state = -10 THEN 'rejected'
        WHEN old_state = -20 THEN 'withdrawn'
        ELSE 'unknown'
     END)
  {% else %}
    state
  {% endif %}
{% endmacro %}
