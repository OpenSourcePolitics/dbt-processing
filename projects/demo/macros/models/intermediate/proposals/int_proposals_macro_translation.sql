{% macro int_proposals_translate_proposal_state(proposal_state) %}
{% set lang = env_var('LANG', 'fr') %} -- Default value is 'fr'

(CASE
    WHEN {{ proposal_state }} = 'evaluating' THEN
        {% if lang == 'fr' %} 'En cours d''évaluation'
        {% elif lang == 'de' %}'In Bewertung'
        {% elif lang == 'en' %}'Evaluating'
        {% elif lang == 'nl' %}'Beoordelen'  
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ proposal_state }} = 'rejected' THEN
        {% if lang == 'fr' %}'Rejetée'
        {% elif lang == 'de' %}'Abgelehnt'
        {% elif lang == 'en' %}'Rejected'
        {% elif lang == 'nl' %}'Afgewezen'      
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ proposal_state }} = 'accepted' THEN
        {% if lang == 'fr' %}'Acceptée'
        {% elif lang == 'de' %}'Akzeptiert'
        {% elif lang == 'en' %}'Accepted'
        {% elif lang == 'nl' %}'Geaccepteerd'  
        {% else %}'Unknown' 
        {% endif %}
    WHEN {{ proposal_state }} = 'not_answered' THEN
        {% if lang == 'fr' %}'Non répondue'
        {% elif lang == 'de' %}'Nicht beantwortet'
        {% elif lang == 'en' %}'Not answered'
        {% elif lang == 'nl' %}'Niet beantwoord'   
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ proposal_state }} = 'published' THEN
        {% if lang == 'fr' %}'Publiée'
        {% elif lang == 'de' %}'Veröffentlicht'
        {% elif lang == 'en' %}'Published'
        {% elif lang == 'nl' %}'Gepubliceerd'      
        {% else %}'Unknown' 
        {% endif %}
    WHEN {{ proposal_state }} = 'validating' THEN
        {% if lang == 'fr' %}'Validation technique'
        {% elif lang == 'de' %}'Technische Validierung'
        {% elif lang == 'en' %}'Technical validation'
        {% elif lang == 'nl' %}'Technische validatie'    
        {% else %}'Unknown'   
        {% endif %}
    WHEN {{ proposal_state }} = 'withdrawn' THEN
        {% if lang == 'fr' %}'Retirée'
        {% elif lang == 'de' %}'Zurückgezogen'
        {% elif lang == 'en' %}'Withdrawn'
        {% elif lang == 'nl' %}'Ingetrokken'      
        {% else %}'Unknown'
        {% endif %}
    WHEN {{ proposal_state }} IS NULL THEN
        {% if lang == 'fr' %}'Pas d''état'
        {% elif lang == 'de' %}'Kein Zustand'
        {% elif lang == 'en' %}'No state'
        {% elif lang == 'nl' %}'Geen status'
        {% else %}'Unknown'
        {% endif %}
    ELSE {{ proposal_state }} 
END)
{% endmacro %}
