USE assurance_360;

DROP TABLE IF EXISTS Sinistres;
DROP TABLE IF EXISTS Objectifs;
DROP TABLE IF EXISTS Contrats;
DROP TABLE IF EXISTS Agents;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Produits;
DROP TABLE IF EXISTS Agences;
DROP TABLE IF EXISTS Calendrier;

CREATE TABLE Agences (
    id_agence VARCHAR(10) PRIMARY KEY,
    nom_agence VARCHAR(100),
    ville_agence VARCHAR(100),
    region_agence VARCHAR(100),
    pays VARCHAR(100),
    type_agence VARCHAR(100)
);

CREATE TABLE Agents (
    id_agent VARCHAR(10) PRIMARY KEY,
    nom_agent VARCHAR(100),
    id_agence VARCHAR(10),
    canal_vente VARCHAR(100),
    date_recrutement DATE,
    niveau_experience VARCHAR(100)
);

CREATE TABLE Calendrier (
    date_jour DATE PRIMARY KEY,
    annee INT,
    trimestre VARCHAR(10),
    mois_numero INT,
    mois VARCHAR(30),
    annee_mois VARCHAR(20),
    debut_mois DATE,
    fin_mois DATE,
    nom_jour VARCHAR(30),
    numero_semaine INT
);

CREATE TABLE Clients (
    id_client VARCHAR(10) PRIMARY KEY,
    nom_client VARCHAR(100),
    genre VARCHAR(20),
    age INT,
    segment_client VARCHAR(100),
    ville VARCHAR(100),
    region VARCHAR(100),
    pays VARCHAR(100),
    date_inscription DATE,
    canal_acquisition VARCHAR(100),
    statut_client VARCHAR(100)
);

CREATE TABLE Produits (
    id_produit VARCHAR(10) PRIMARY KEY,
    nom_produit VARCHAR(150),
    categorie_produit VARCHAR(100),
    type_couverture VARCHAR(100),
    niveau_risque VARCHAR(100),
    taux_commission_standard DECIMAL(10,4)
);

CREATE TABLE Contrats (
    id_contrat VARCHAR(15) PRIMARY KEY,
    id_client VARCHAR(10),
    id_produit VARCHAR(10),
    id_agent VARCHAR(10),
    id_agence VARCHAR(10),
    date_debut DATE,
    date_fin DATE,
    statut_contrat VARCHAR(50),
    montant_prime BIGINT,
    montant_commission BIGINT,
    frequence_paiement VARCHAR(50),
    renouvele VARCHAR(10),
    mode_paiement VARCHAR(50),
    duree_contrat_mois INT
);

CREATE TABLE Sinistres (
    id_sinistre VARCHAR(15) PRIMARY KEY,
    id_contrat VARCHAR(15),
    date_sinistre DATE,
    type_sinistre VARCHAR(100),
    montant_reclame BIGINT,
    montant_regle BIGINT,
    statut_sinistre VARCHAR(50),
    date_reglement DATE,
    delai_reglement_jours INT,
    gravite_sinistre VARCHAR(50)
);

CREATE TABLE Objectifs (
    id_objectif VARCHAR(20) PRIMARY KEY,
    annee INT,
    mois INT,
    id_agence VARCHAR(10),
    id_produit VARCHAR(10),
    objectif_primes BIGINT,
    objectif_nouveaux_contrats INT,
    objectif_taux_renouvellement DECIMAL(10,4),
    objectif_ratio_sinistres_primes DECIMAL(10,4),
    date_objectif DATE
);