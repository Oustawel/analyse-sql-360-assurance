USE assurance_360;

DROP TABLE IF EXISTS sinistres_staging;

CREATE TABLE sinistres_staging (
    id_sinistre VARCHAR(50),
    id_contrat VARCHAR(50),
    date_sinistre VARCHAR(50),
    type_sinistre VARCHAR(100),
    montant_reclame VARCHAR(50),
    montant_regle VARCHAR(50),
    statut_sinistre VARCHAR(50),
    date_reglement VARCHAR(50),
    delai_reglement_jours VARCHAR(50),
    gravite_sinistre VARCHAR(50)
);

SELECT COUNT(*) FROM sinistres_staging;

SELECT id_sinistre, COUNT(*) AS nb
FROM sinistres_staging
GROUP BY id_sinistre
HAVING COUNT(*) > 1;

TRUNCATE TABLE sinistres;

INSERT INTO sinistres (
    id_sinistre,
    id_contrat,
    date_sinistre,
    type_sinistre,
    montant_reclame,
    montant_regle,
    statut_sinistre,
    date_reglement,
    delai_reglement_jours,
    gravite_sinistre
)
SELECT
    id_sinistre,
    id_contrat,

    CASE
        WHEN date_sinistre REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_sinistre, '%Y-%m-%d')
        WHEN date_sinistre REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_sinistre, '%c/%e/%Y')
        ELSE NULL
    END AS date_sinistre,

    type_sinistre,

    CAST(REPLACE(montant_reclame, ',', '') AS UNSIGNED) AS montant_reclame,
    CAST(REPLACE(montant_regle, ',', '') AS UNSIGNED) AS montant_regle,

    statut_sinistre,

    CASE
        WHEN date_reglement IS NULL OR date_reglement = '' THEN NULL
        WHEN date_reglement REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_reglement, '%Y-%m-%d')
        WHEN date_reglement REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_reglement, '%c/%e/%Y')
        ELSE NULL
    END AS date_reglement,

    CASE
        WHEN delai_reglement_jours IS NULL OR delai_reglement_jours = '' THEN NULL
        ELSE CAST(delai_reglement_jours AS UNSIGNED)
    END AS delai_reglement_jours,

    gravite_sinistre
FROM sinistres_staging;

SELECT COUNT(*) FROM sinistres;

INSERT INTO sinistres (
    id_sinistre,
    id_contrat,
    date_sinistre,
    type_sinistre,
    montant_reclame,
    montant_regle,
    statut_sinistre,
    date_reglement,
    delai_reglement_jours,
    gravite_sinistre
)
SELECT
    id_sinistre,
    id_contrat,

    CASE
        WHEN date_sinistre REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_sinistre, '%Y-%m-%d')
        WHEN date_sinistre REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_sinistre, '%c/%e/%Y')
        ELSE NULL
    END AS date_sinistre,

    type_sinistre,

    CAST(REPLACE(montant_reclame, ',', '') AS UNSIGNED) AS montant_reclame,
    CAST(REPLACE(montant_regle, ',', '') AS UNSIGNED) AS montant_regle,

    statut_sinistre,

    CASE
        WHEN date_reglement IS NULL OR date_reglement = '' THEN NULL
        WHEN date_reglement REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_reglement, '%Y-%m-%d')
        WHEN date_reglement REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_reglement, '%c/%e/%Y')
        ELSE NULL
    END AS date_reglement,

    CASE
        WHEN delai_reglement_jours IS NULL OR delai_reglement_jours = '' THEN NULL
        ELSE CAST(delai_reglement_jours AS UNSIGNED)
    END AS delai_reglement_jours,

    gravite_sinistre
FROM sinistres_staging;

SELECT COUNT(*) FROM sinistres_staging;

TRUNCATE TABLE sinistres;

INSERT INTO sinistres (
    id_sinistre,
    id_contrat,
    date_sinistre,
    type_sinistre,
    montant_reclame,
    montant_regle,
    statut_sinistre,
    date_reglement,
    delai_reglement_jours,
    gravite_sinistre
)
SELECT
    id_sinistre,
    id_contrat,

    CASE
        WHEN date_sinistre REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_sinistre, '%Y-%m-%d')
        WHEN date_sinistre REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_sinistre, '%c/%e/%Y')
        ELSE NULL
    END AS date_sinistre,

    type_sinistre,

    CAST(CAST(REPLACE(montant_reclame, ',', '') AS DECIMAL(18,2)) AS UNSIGNED) AS montant_reclame,
    CAST(CAST(REPLACE(montant_regle, ',', '') AS DECIMAL(18,2)) AS UNSIGNED) AS montant_regle,

    statut_sinistre,

    CASE
        WHEN date_reglement IS NULL OR date_reglement = '' THEN NULL
        WHEN date_reglement REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(date_reglement, '%Y-%m-%d')
        WHEN date_reglement REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            THEN STR_TO_DATE(date_reglement, '%c/%e/%Y')
        ELSE NULL
    END AS date_reglement,

    CASE
        WHEN delai_reglement_jours IS NULL OR delai_reglement_jours = '' THEN NULL
        ELSE CAST(ROUND(CAST(delai_reglement_jours AS DECIMAL(10,2)), 0) AS UNSIGNED)
    END AS delai_reglement_jours,

    gravite_sinistre
FROM sinistres_staging;

SELECT COUNT(*) FROM sinistres;

SELECT 'Agences' AS table_nom, COUNT(*) AS nb_lignes FROM agences
UNION ALL
SELECT 'Agents', COUNT(*) FROM agents
UNION ALL
SELECT 'Calendrier', COUNT(*) FROM calendrier
UNION ALL
SELECT 'Clients', COUNT(*) FROM clients
UNION ALL
SELECT 'Produits', COUNT(*) FROM produits
UNION ALL
SELECT 'Contrats', COUNT(*) FROM contrats
UNION ALL
SELECT 'Sinistres', COUNT(*) FROM sinistres
UNION ALL
SELECT 'Objectifs', COUNT(*) FROM objectifs;