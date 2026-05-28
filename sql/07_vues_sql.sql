USE assurance_360;


-- Vue KPI global

CREATE OR REPLACE VIEW vue_kpis_globaux AS
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

-- test

SELECT * FROM vue_kpis_globaux;

-- Vue performance produits

CREATE OR REPLACE VIEW vue_performance_produits AS
WITH primes_produits AS (
    SELECT
        p.categorie_produit,
        p.nom_produit,
        COUNT(DISTINCT c.id_contrat) AS nombre_contrats,
        SUM(c.montant_prime) AS total_primes,
        SUM(c.montant_commission) AS total_commissions
    FROM Contrats c
    JOIN Produits p
        ON c.id_produit = p.id_produit
    GROUP BY
        p.categorie_produit,
        p.nom_produit
),
sinistres_produits AS (
    SELECT
        p.categorie_produit,
        p.nom_produit,
        COUNT(DISTINCT s.id_sinistre) AS nombre_sinistres,
        SUM(s.montant_regle) AS total_sinistres_regles
    FROM Sinistres s
    JOIN Contrats c
        ON s.id_contrat = c.id_contrat
    JOIN Produits p
        ON c.id_produit = p.id_produit
    GROUP BY
        p.categorie_produit,
        p.nom_produit
)
SELECT
    pp.categorie_produit,
    pp.nom_produit,
    pp.nombre_contrats,
    pp.total_primes,
    COALESCE(sp.nombre_sinistres, 0) AS nombre_sinistres,
    COALESCE(sp.total_sinistres_regles, 0) AS total_sinistres_regles,
    pp.total_primes - pp.total_commissions - COALESCE(sp.total_sinistres_regles, 0) AS marge_estimee,
    COALESCE(sp.total_sinistres_regles, 0) / pp.total_primes AS ratio_sinistres_primes
FROM primes_produits pp
LEFT JOIN sinistres_produits sp
    ON pp.categorie_produit = sp.categorie_produit
   AND pp.nom_produit = sp.nom_produit;
   
   -- test
   
   SELECT *
FROM vue_performance_produits
ORDER BY total_primes DESC;

SELECT *
FROM vue_performance_produits
ORDER BY ratio_sinistres_primes DESC;

-- 3. Vue performance agences

CREATE OR REPLACE VIEW vue_performance_agences AS
WITH primes_agences AS (
    SELECT
        a.nom_agence,
        a.ville_agence,
        a.region_agence,
        COUNT(DISTINCT c.id_contrat) AS nombre_contrats,
        SUM(c.montant_prime) AS total_primes,
        SUM(c.montant_commission) AS total_commissions
    FROM Contrats c
    JOIN Agences a
        ON c.id_agence = a.id_agence
    GROUP BY
        a.nom_agence,
        a.ville_agence,
        a.region_agence
),
sinistres_agences AS (
    SELECT
        a.nom_agence,
        COUNT(DISTINCT s.id_sinistre) AS nombre_sinistres,
        SUM(s.montant_regle) AS total_sinistres_regles
    FROM Sinistres s
    JOIN Contrats c
        ON s.id_contrat = c.id_contrat
    JOIN Agences a
        ON c.id_agence = a.id_agence
    GROUP BY
        a.nom_agence
)
SELECT
    pa.nom_agence,
    pa.ville_agence,
    pa.region_agence,
    pa.nombre_contrats,
    pa.total_primes,
    COALESCE(sa.nombre_sinistres, 0) AS nombre_sinistres,
    COALESCE(sa.total_sinistres_regles, 0) AS total_sinistres_regles,
    pa.total_primes - pa.total_commissions - COALESCE(sa.total_sinistres_regles, 0) AS marge_estimee,
    COALESCE(sa.total_sinistres_regles, 0) / pa.total_primes AS ratio_sinistres_primes
FROM primes_agences pa
LEFT JOIN sinistres_agences sa
    ON pa.nom_agence = sa.nom_agence;
    
    -- test 
    SELECT *
FROM vue_performance_agences
ORDER BY marge_estimee DESC;

-- 4. Vue performance segments clients

CREATE OR REPLACE VIEW vue_performance_segments AS
SELECT
    cl.segment_client,
    COUNT(DISTINCT cl.id_client) AS nombre_clients,
    COUNT(DISTINCT c.id_contrat) AS nombre_contrats,
    SUM(c.montant_prime) AS total_primes,
    AVG(c.montant_prime) AS prime_moyenne,
    SUM(CASE WHEN c.renouvele = 'Oui' THEN 1 ELSE 0 END) AS contrats_renouveles,
    SUM(CASE WHEN c.renouvele = 'Oui' THEN 1 ELSE 0 END) / COUNT(*) AS taux_renouvellement
FROM Contrats c
JOIN Clients cl
    ON c.id_client = cl.id_client
GROUP BY cl.segment_client;

-- test 

SELECT *
FROM vue_performance_segments
ORDER BY taux_renouvellement DESC;

-- 5. Vue objectifs par année

CREATE OR REPLACE VIEW vue_objectifs_annuels AS
WITH realise AS (
    SELECT
        YEAR(date_debut) AS annee,
        SUM(montant_prime) AS total_primes
    FROM Contrats
    GROUP BY YEAR(date_debut)
),
objectifs AS (
    SELECT
        annee,
        SUM(objectif_primes) / 36 AS objectif_primes_ajuste
    FROM Objectifs
    GROUP BY annee
)
SELECT
    r.annee,
    r.total_primes,
    o.objectif_primes_ajuste,
    r.total_primes - o.objectif_primes_ajuste AS ecart_objectif,
    r.total_primes / o.objectif_primes_ajuste AS taux_atteinte
FROM realise r
JOIN objectifs o
    ON r.annee = o.annee;
    
    -- test 
    
    SELECT *
FROM vue_objectifs_annuels
ORDER BY annee;

