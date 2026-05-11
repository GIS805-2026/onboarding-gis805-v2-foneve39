# Board Brief — S01

## Question du CEO
Quelles catégories déclinent dans quelles régions et pourquoi?


## Réponse exécutive
Actuellement, nous ne pouvons pas répondre avec précision à cette question.
Notre système actuel (ERP/OLTP) est une "caisse enregistreuse" optimisée pour saisir des transactions individuelles, pas pour analyser des tendances globales.Les informations sont "normalisées" (éparpillées) pour éviter les erreurs, ce qui rend les calculs globaux (ex: total par région) extrêmement lourds et lents. Pour identifier un déclin (comparaison temporelle) par catégorie et par région, nous devons transformer nos données brutes en un modèle décisionnel.


Les obstacles concrets identifiés :

    - Dispersion des données : L'information est dispersée à travers 24 tables. Les informations de localisation (Région) et de catalogue (Catégorie) ne sont pas liées de manière directe aux lignes de vente, nécessitant des requêtes SQL complexes.

    - Absence de contexte temporel : Nous n'avons pas de hiérarchie de dates (ex: grouper les jours en trimestres).

    - Volume vs Performance : Analyser 534 commandes sur un système transactionnel risque de ralentir les opérations de vente en direct.



## Décisions de modélisation
Faire un schéma en étoile :

- Fact : Sales

- Dimensions : Product, Region ou Store, date.

- Mesures : Total des ventes ($), Quantités totales vendues.

- Hiérarchie : Temps : Année > Trimestre > Mois > Jour et Produit : Catégorie > Produit.



## Preuve : Pourquoi l'approche actuelle n'est pas durable

1. La complexité des jointures
Pour répondre à une question simple comme "Ventes par catégorie et région", nous devons actuellement écrire une requête qui "force" les liens entre des tables éparpillées. Plus on ajoute de critères (le temps, les promotions, les retours), plus le risque d'erreur humaine augmente.

Exemple de la complexité actuelle :

SQL
-- Ce qu'il faut faire AUJOURD'HUI pour croiser 3 axes

        SELECT
            g.region,
            p.category,
            SUM(l.line_total)
        FROM raw_order_lines l
        JOIN raw_orders o ON l.order_number = o.order_number
        JOIN raw_dim_product p ON l.product_id = p.product_id
        JOIN raw_dim_store s ON o.store_id = s.store_id
        JOIN raw_dim_geography g ON s.zip_code = g.zip_code
        GROUP BY 1, 2;

Note : Chaque JOIN supplémentaire ralentit la réponse et multiplie les chances de doubler les chiffres par erreur.

2. Le problème du facteur "Temps"
Actuellement, l'ERP stocke des dates précises (ex: 2026-05-10 10:45:00). Pour obtenir un "Trimestre", nous devons transformer la donnée à la volée.

Aujourd'hui : Calcul manuel à chaque rapport (lent et incohérent).

Demain (Décisionnel) : Une table Dim_Date où le trimestre est déjà calculé et indexé.

3. Verdict : Un diagnostic, pas une solution
"On peut extraire une réponse ponctuelle avec beaucoup d'efforts manuels, mais ce n'est pas une solution durable. C'est une méthode artisanale : longue à produire, impossible à automatiser et risquée pour la prise de décision stratégique."



## Validation/Exploration
On a 24 tables dispersées dans notre entrepot
  (echo "SHOW TABLES;" | duckdb db/nexamart.duckdb)

On a 255 clients, 534 commandes et 61 produits.
  (echo "SELECT
    (SELECT COUNT(*) FROM raw_dim_customer) as nb_clients,
    (SELECT COUNT(*) FROM raw_orders) as nb_commandes,
    (SELECT COUNT(*) FROM raw_dim_product) as nb_produits;" | duckdb db/nexamart.duckdb)

Ventes par région :
│ Québec    │      90443.76 │
│ Ontario   │      84851.02 │
│ Alberta   │      30941.14 │
│ Outaouais │      30066.31 │
│ Estrie    │      25743.14 │
│ BC        │      25681.62 │

  (cd /workspaces/onboarding-gis805-v2-foneve39
  duckdb db/nexamart.duckdb <<'SQL'
  SELECT
    s.region,
    ROUND(SUM(l.line_total), 2) AS total_revenue
  FROM raw_order_lines l
  JOIN raw_orders o ON l.order_number = o.order_number
  JOIN raw_dim_store s ON o.store_id = s.store_id
  GROUP BY s.region
  ORDER BY total_revenue DESC;
  SQL)


## Risques / limites

- Performance & Stabilité : Lancer des requêtes analytiques complexes directement sur l'OLTP risque de ralentir les opérations quotidiennes (saisie des commandes, facturation).

- Qualité des données : La dispersion dans 24 tables augmente le risque d'erreurs de jointure et d'incohérences dans les résultats (ex: doublons de produits ou régions mal typées).

- Absence de "Time-Travel" : Sans table Dim_Date robuste, il est difficile d'analyser les tendances saisonnières ou de comparer les trimestres (QoQ) de façon fiable.

- Manque de contexte (le "Pourquoi") : Les données brutes disent ce qui arrive, mais pas pourquoi. Sans intégration de données externes (météo, prix concurrents, ruptures de stock), la réponse restera partielle.


## Prochaine recommandation

- Ingestion & Nettoyage : Transformer les 24 tables sources en un Modèle en Étoile (Star Schema) via un outil de transformation (comme dBT) pour simplifier les requêtes.

