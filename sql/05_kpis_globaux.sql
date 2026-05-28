USE assurance_360

-- KPI globaux
WITH primes AS (
    SELECT
        COUNT(DISTINCT id_contrat) AS nombre_contrats,
        COUNT(DISTINCT id_client) AS nombre_clients,
        SUM(montant_prime) AS total_primes,
        SUM(montant_commission) AS total_commissions
    FROM Contrats
),
sinistres AS (
    SELECT
        COUNT(DISTINCT id_sinistre) AS nombre_sinistres,
        SUM(montant_regle) AS total_sinistres_regles,
        SUM(montant_reclame) AS total_sinistres_reclames
    FROM Sinistres
)
SELECT
    p.nombre_contrats,
    p.nombre_clients,
    s.nombre_sinistres,
    p.total_primes,
    p.total_commissions,
    s.total_sinistres_regles,
    s.total_sinistres_reclames,
    p.total_primes - p.total_commissions - s.total_sinistres_regles AS marge_estimee,
    s.total_sinistres_regles / p.total_primes AS ratio_sinistres_primes
FROM primes p
CROSS JOIN sinistres s;


-- Taux de renouvellement

SELECT
    COUNT(*) AS nombre_contrats,
    SUM(CASE WHEN renouvele = 'Oui' THEN 1 ELSE 0 END) AS contrats_renouveles,
    SUM(CASE WHEN renouvele = 'Oui' THEN 1 ELSE 0 END) / COUNT(*) AS taux_renouvellement
FROM Contrats;

-- Contrats par statut

SELECT
    statut_contrat,
    COUNT(*) AS nombre_contrats,
    SUM(montant_prime) AS total_primes
FROM Contrats
GROUP BY statut_contrat
ORDER BY nombre_contrats DESC;

-- Objectif vs réalisé global

WITH realise AS (
    SELECT
        SUM(montant_prime) AS total_primes
    FROM Contrats
),
objectif AS (
    SELECT
        SUM(objectif_primes) / 36 AS objectif_primes_ajuste
    FROM Objectifs
)
SELECT
    r.total_primes,
    o.objectif_primes_ajuste,
    r.total_primes - o.objectif_primes_ajuste AS ecart_objectif,
    r.total_primes / o.objectif_primes_ajuste AS taux_atteinte_objectif
FROM realise r
CROSS JOIN objectif o;

