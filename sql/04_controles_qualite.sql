USE assurance_360;

SELECT 'Agences' AS table_nom, COUNT(*) AS nb_lignes FROM Agences
UNION ALL
SELECT 'Agents', COUNT(*) FROM Agents
UNION ALL
SELECT 'Calendrier', COUNT(*) FROM Calendrier
UNION ALL
SELECT 'Clients', COUNT(*) FROM Clients
UNION ALL
SELECT 'Produits', COUNT(*) FROM Produits
UNION ALL
SELECT 'Contrats', COUNT(*) FROM Contrats
UNION ALL
SELECT 'Sinistres', COUNT(*) FROM Sinistres
UNION ALL
SELECT 'Objectifs', COUNT(*) FROM Objectifs;


-- 1. Vérifier les doublons sur les clés primaires
USE assurance_360;

SELECT id_agence, COUNT(*) AS nb
FROM Agences
GROUP BY id_agence
HAVING COUNT(*) > 1;

SELECT id_agent, COUNT(*) AS nb
FROM Agents
GROUP BY id_agent
HAVING COUNT(*) > 1;

SELECT id_client, COUNT(*) AS nb
FROM Clients
GROUP BY id_client
HAVING COUNT(*) > 1;

SELECT id_produit, COUNT(*) AS nb
FROM Produits
GROUP BY id_produit
HAVING COUNT(*) > 1;

SELECT id_contrat, COUNT(*) AS nb
FROM Contrats
GROUP BY id_contrat
HAVING COUNT(*) > 1;

SELECT id_sinistre, COUNT(*) AS nb
FROM Sinistres
GROUP BY id_sinistre
HAVING COUNT(*) > 1;

SELECT id_objectif, COUNT(*) AS nb
FROM Objectifs
GROUP BY id_objectif
HAVING COUNT(*) > 1;

-- 2. Vérifier les contrats sans client, produit, agent ou agence
SELECT c.id_contrat, c.id_client
FROM Contrats c
LEFT JOIN Clients cl ON c.id_client = cl.id_client
WHERE cl.id_client IS NULL;

SELECT c.id_contrat, c.id_produit
FROM Contrats c
LEFT JOIN Produits p ON c.id_produit = p.id_produit
WHERE p.id_produit IS NULL;

SELECT c.id_contrat, c.id_agent
FROM Contrats c
LEFT JOIN Agents a ON c.id_agent = a.id_agent
WHERE a.id_agent IS NULL;

SELECT c.id_contrat, c.id_agence
FROM Contrats c
LEFT JOIN Agences ag ON c.id_agence = ag.id_agence
WHERE ag.id_agence IS NULL;

-- 3. Vérifier les sinistres sans contrat
SELECT s.id_sinistre, s.id_contrat
FROM Sinistres s
LEFT JOIN Contrats c ON s.id_contrat = c.id_contrat
WHERE c.id_contrat IS NULL;


-- 4. Vérifier les objectifs sans agence ou produit
SELECT o.id_objectif, o.id_agence
FROM Objectifs o
LEFT JOIN Agences a ON o.id_agence = a.id_agence
WHERE a.id_agence IS NULL;

SELECT o.id_objectif, o.id_produit
FROM Objectifs o
LEFT JOIN Produits p ON o.id_produit = p.id_produit
WHERE p.id_produit IS NULL;


-- 5. Vérifier les montants négatifs
SELECT *
FROM Contrats
WHERE montant_prime < 0
   OR montant_commission < 0;

SELECT *
FROM Sinistres
WHERE montant_reclame < 0
   OR montant_regle < 0;

SELECT *
FROM Objectifs
WHERE objectif_primes < 0
   OR objectif_nouveaux_contrats < 0;
   
   
   -- 6. Vérifier les dates incohérentes
SELECT *
FROM Contrats
WHERE date_fin < date_debut;

SELECT *
FROM Sinistres
WHERE date_reglement IS NOT NULL
  AND date_reglement < date_sinistre;


