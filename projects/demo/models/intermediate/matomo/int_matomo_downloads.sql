SELECT
    date,
    nb_visits,
    nb_hits,
    sum_time_spent,
    index,
    nb_uniq_visitors,
    label,
    url,
    -- Extraction du nom du fichier sans l'extension
    split_part(split_part(url, '/', -1), '.', 1) AS document_name,
    -- Extraction de l'extension (pdf, jpeg, etc.)
    split_part(split_part(url, '/', -1), '.', 2) AS document_extension
FROM {{ref ("stg_matomo_downloads")}}





