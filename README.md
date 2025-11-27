# SuperShopAnalytics

## Présentation

SuperShopAnalytics est une base de données exemple (PostgreSQL) simulant un petit magasin en ligne ("supershop"). Elle contient des tables pour les catégories de produits, les produits, les clients, les statuts de commande, les commandes et les lignes de commandes.  
Le but est de fournir un modèle simple mais complet pour apprendre ou démontrer des requêtes SQL (création de schéma, jointures, agrégations, analyses de ventes, etc.).

## Contenu du dépôt

- Le schéma complet (tables + contraintes) pour la base `supershopanalytics`.  
- Des données de démonstration : catégories, produits, clients, statuts, commandes, lignes de commandes.  
- Exemples de requêtes SQL : calcul de chiffre d’affaires, panier moyen, CA par mois, CA par catégorie, montants “perdus” (annulations), etc.  
- (Optionnel) Un script Python d’initialisation utilisant `psycopg` pour recréer facilement la base et insérer les données.

## Prérequis

- PostgreSQL (version récente)  
- (Optionnel) Python 3 + module `psycopg` ou `psycopg2` si tu utilises le script d’initialisation  
- Accès en écriture/lecture à une base PostgreSQL  

## Installation / Initialisation

1. Cloner le dépôt :  
   ```bash
   git clone https://github.com/khaoulaAbid/sql-data-project.git
   cd sql-data-project
