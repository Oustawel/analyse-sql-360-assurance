# Insights Business — Analyse SQL 360 Assurance

## Vue d’ensemble

Ce projet SQL analyse la performance commerciale et technique d’un portefeuille d’assurance fictif en Guinée.

L’objectif est d’utiliser MySQL Workbench pour interroger une base relationnelle, contrôler la qualité des données, calculer les principaux KPIs et produire des analyses business exploitables.

Le projet couvre les contrats, clients, produits, agences, agents, sinistres, objectifs et calendrier.

---

## Contrôles qualité

Avant l’analyse, plusieurs contrôles qualité ont été réalisés :

- vérification du nombre de lignes importées ;
- recherche de doublons sur les clés primaires ;
- vérification des contrats sans client, produit, agent ou agence ;
- vérification des sinistres sans contrat ;
- vérification des objectifs sans agence ou produit ;
- contrôle des montants négatifs ;
- contrôle des dates incohérentes.

Les contrôles réalisés n’ont pas révélé d’anomalie bloquante.

---

## KPIs globaux

Les requêtes SQL permettent de calculer les indicateurs suivants :

- nombre de contrats ;
- nombre de clients ;
- nombre de sinistres ;
- total des primes ;
- total des commissions ;
- total des sinistres réglés ;
- marge estimée ;
- ratio sinistres/primes ;
- taux de renouvellement ;
- taux d’atteinte des objectifs.

Ces KPIs donnent une vue synthétique de la performance du portefeuille.

---

## Insight 1 — La Multirisque Professionnelle tire les primes

La Multirisque Professionnelle est le produit qui génère le plus de primes.

### Lecture business

Ce produit constitue un moteur important de chiffre d’affaires.  
L’entreprise doit continuer à le suivre de près, car une forte dépendance à un produit majeur peut représenter à la fois une opportunité de croissance et un risque de concentration.

---

## Insight 2 — Le produit Auto présente le plus fort ratio sinistres/primes

Le produit Auto ressort avec le ratio sinistres/primes le plus élevé.

### Lecture business

Ce produit consomme une part plus importante des primes sous forme de sinistres réglés.  
Il doit faire l’objet d’une surveillance prioritaire sur la tarification, la sélection des risques et le suivi des sinistres.

---

## Insight 3 — Conakry Kaloum est l’agence la plus contributrice à la marge

L’agence Conakry Kaloum ressort comme l’agence ayant la plus forte marge estimée.

### Lecture business

La performance commerciale semble fortement concentrée autour de Conakry.  
L’enjeu est de consolider les agences fortes tout en identifiant les leviers de développement dans les agences régionales.

---

## Insight 4 — Le segment Grande Entreprise renouvelle le mieux

Le segment Grande Entreprise présente le meilleur taux de renouvellement.

### Lecture business

Ce segment semble plus fidèle et potentiellement plus intéressant pour la valeur long terme.  
Il peut être priorisé dans les actions de rétention et de développement commercial.

---

## Insight 5 — L’objectif est dépassé en 2023

L’analyse SQL montre que l’objectif de primes est dépassé en 2023.

### Lecture business

L’année 2023 ressort comme une année de bonne performance par rapport aux objectifs ajustés.  
Les autres années doivent être analysées avec prudence selon la couverture temporelle des données.

---

## Recommandations

1. Capitaliser sur la Multirisque Professionnelle, principal moteur de primes.
2. Renforcer le suivi technique du produit Auto, qui présente le plus fort ratio sinistres/primes.
3. Consolider les performances de Conakry Kaloum et analyser les bonnes pratiques de cette agence.
4. Développer les actions de fidélisation sur le segment Grande Entreprise.
5. Utiliser les vues SQL créées comme base d’analyse réutilisable pour les reportings futurs.

---

## Conclusion

Ce projet montre comment SQL peut être utilisé pour analyser une base relationnelle métier, vérifier la qualité des données, calculer des KPIs et produire des insights business.

Il complète les projets Power BI et Excel en démontrant la capacité à interroger directement les données à la source.