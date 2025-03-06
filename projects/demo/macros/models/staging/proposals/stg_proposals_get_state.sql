{% macro stg_proposals_get_state(relation) %}
  {% if check_column_type(relation, 'state', 'bigint') %}
    (CASE
        WHEN state = 0 THEN 'not_answered'
        WHEN state = 10 THEN 'evaluating'
        WHEN state = 20 THEN 'accepted'
        WHEN state = -10 THEN 'rejected'
        WHEN state = -20 THEN 'withdrawn'
        ELSE 'unknown'
     END) AS state
  {% else %}
    state
  {% endif %}
{% endmacro %}
