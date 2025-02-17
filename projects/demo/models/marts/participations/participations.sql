    WITH participations_proposals AS (
            SELECT decidim_users.id,
                decidim_proposals_proposals.decidim_component_id,
                'Decidim::Proposals::Proposal' AS "participation_type",
                decidim_proposals_proposals.id::text AS "participation_id",
                decidim_proposals_proposals.created_at AS participation_date
            FROM {{ ref("proposals")}} AS decidim_proposals_proposals
                JOIN decidim_coauthorships on decidim_coauthorships.coauthorable_id = decidim_proposals_proposals.id
                JOIN {{ ref("users")}} AS decidim_users on decidim_users.id = decidim_coauthorships.decidim_author_id
            where coauthorable_type = 'Decidim::Proposals::Proposal'
    ), participations_endorsements as (
            SELECT decidim_users.id,
                decidim_endorsements.decidim_component_id,
                'Decidim::Endorsements::Endorsement' as "participation_type",
                decidim_endorsements.id::text as "participation_id", 
                decidim_endorsements.created_at as participation_date
            FROM {{ ref("endorsements")}} as decidim_endorsements
                JOIN {{ ref("users")}} AS decidim_users on decidim_users.id = decidim_endorsements.decidim_author_id
    ), participations_comments as (
            SELECT decidim_users.id,
                decidim_component_id,
                'Decidim::Comments::Comment' as "participation_type",
                decidim_comments_comments.id::text as "participation_id",
                decidim_comments_comments.created_at as contribution_date
            FROM {{ ref("comments")}} decidim_comments_comments
                JOIN {{ ref("users")}} AS decidim_users on decidim_users.id = decidim_comments_comments.decidim_author_id
    ), participations_proposal_votes as (
            SELECT decidim_users.id,
                decidim_proposals_proposals.decidim_component_id,
                'Decidim::Proposals::ProposalVote' as "participation_type",
                decidim_proposals_proposal_votes.id::text as "participation_id",
                decidim_proposals_proposal_votes.created_at as participation_date
            FROM {{ ref("proposals_votes")}} as decidim_proposals_proposal_votes
                JOIN {{ ref("users")}} AS decidim_users on decidim_users.id = decidim_author_id
                JOIN {{ ref("proposals")}} as decidim_proposals_proposals on decidim_proposals_proposal_votes.decidim_proposal_id = decidim_proposals_proposals.id
    ), participations_answers as (
            SELECT distinct
                decidim_user_id,
                decidim_component_id,
                'Decidim::Forms::Answer' as "participation_type",
              ('x'||lpad(decidim_forms_answers.session_token,16,'0'))::bit(64)::bigint::text as "participation_id",
              decidim_forms_answers.created_at::date as participation_date
            FROM {{ ref("forms_answers")}} as decidim_forms_answers
    ), participations_debates as (
            SELECT decidim_author_id as decidim_user_id,
                decidim_component_id,
                'Decidim::Debates::Debate' as "participation_type",
                id::text as participation_id,
                created_at as participation_date
            FROM {{ ref("debates")}} decidim_debates_debates
    ), participations_budgets_projects_votes as (
            SELECT
                decidim_user_id,
                decidim_component_id,
                'Decidim::Budgets::Project::Vote' as participation_type,
                order_id::text as participation_id,
                created_at as participation_date
            FROM {{ ref("projects_votes")}} decidim_bugdets_projects_votes
    ), participations_meetings_registrations as (
            SELECT
                decidim_user_id,
                decidim_component_id,
                'Decidim::Meetings::Registration' as participation_type,
                decidim_meetings_meetings.id::text as participation_id,
                decidim_meetings_registrations.created_at as participation_date
            FROM {{ ref("meetings")}} decidim_meetings_meetings
                join decidim_meetings_registrations on decidim_meetings_registrations.decidim_meeting_id = decidim_meetings_meetings.id
    ), participations as (
        SELECT * FROM participations_proposals union all
        SELECT * FROM participations_endorsements union all
        SELECT * FROM participations_comments union all
        SELECT * FROM participations_proposal_votes union all
        SELECT * from participations_answers union all
        SELECT * from participations_debates union all
        SELECT * from participations_budgets_projects_votes union all
        SELECT * from participations_meetings_registrations
    )
    SELECT
        distinct participations.id as "user_id",
        substr(participation_id,1,10)::bigint as participation_id,
        decidim_component_id,
        participation_type,
        participation_date
    from participations