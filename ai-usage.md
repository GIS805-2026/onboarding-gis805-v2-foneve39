# Trace d'usage IA — GIS805

> Chaque interaction significative avec un outil IA doit être documentée ici.
> Ce fichier est **obligatoire** et évalué à chaque remise.

## Format par entrée

```
### YYYY-MM-DD — Séance SXX
- **Modèle :** (ChatGPT-4o, Claude, Copilot, etc.)
- **Prompt :** (copier-coller exact)
- **Résultat :** (résumé de ce que l'IA a produit)
- **Validation :** (comment vous avez vérifié/modifié le résultat)
- **Justification :** (pourquoi cette interaction était nécessaire)
```

---

### 2026-01-XX — Séance S00 *(exemple — supprimez cette entrée quand vous ajoutez les vôtres)*
- **Modèle :** GitHub Copilot Chat
- **Prompt :** « Qu'est-ce qui se trouve dans mon dépôt ? Explique-moi la structure du projet. »
- **Résultat :** Copilot a listé les dossiers principaux (sql/, answers/, data/, docs/) et expliqué le rôle de chacun dans le contexte d'un entrepôt dimensionnel.
- **Validation :** J'ai comparé la réponse avec le README.md et le contenu réel des dossiers — tout correspondait.
- **Justification :** Première prise de contact avec le dépôt ; je voulais comprendre l'organisation avant de lancer les commandes.

<!-- Ajoutez vos entrées ci-dessous -->
Séance 2
## Résumé clair et étape par étape

1. Tu as demandé comment voir les colonnes d’une table dans DuckDB.
2. Je t’ai expliqué qu’on peut utiliser `DESCRIBE raw_orders;` ou interroger `information_schema.columns`.
3. Ensuite tu as voulu savoir s’il y a des surrogate keys (`SK`) dans les tables.
4. Je t’ai montré que chercher simplement `sk` ou `_key` n’est pas une preuve suffisante, car les clés peuvent s’appeler `id`, `customer_id`, etc.
5. Tu as demandé le nombre de clients, commandes et produits.
6. J’ai trouvé les bonnes tables et j’ai exécuté la requête. Résultat :
   - 255 clients
   - 534 commandes
   - 61 produits
7. Tu as demandé une requête pour le revenu par catégorie par région.
8. J’ai vérifié les tables pertinentes (`raw_fact_sales`, `raw_dim_product`, `raw_dim_customer`) et je t’ai donné le SQL correct en expliquant le grain.
9. Tu as demandé à voir les colonnes de `raw_dim_store`.
10. Je t’ai montré le schéma de `raw_dim_store`.
11. Tu as voulu voir les 5 premières lignes de `raw_order_lines`.
12. Après vérification, j’ai exécuté la requête demandée.
13. Tu as demandé la jointure entre `raw_orders`, `raw_dim_store`, et `raw_order_lines`, avec la somme de `line_total` par région.
14. J’ai vérifié les colonnes nécessaires, puis j’ai produit et exécuté la requête.
15. Tu as demandé un code shell prêt à copier/coller et fonctionnel.
16. Je t’ai fourni un bloc `bash` avec `duckdb nexamart.duckdb <<'SQL' ... SQL`.
17. Enfin, tu as demandé d’afficher le montant avec deux décimales.
18. Je t’ai adapté la requête pour utiliser `ROUND(SUM(l.line_total), 2)`.


---

### 2026-05-10 — Séance S01

* **Modèle :** Gemini 1.5 Flash
* **Prompt :** « Pourquoi un ERP ne peut-il pas répondre directement a "ventes par catégorie par région par trimestre" ? »
* **Résultat :** L'IA a expliqué la distinction entre le mode transactionnel (**OLTP**) et le mode décisionnel (**OLAP**). Elle a précisé que l'ERP est optimisé pour l'écriture et la saisie de données, tandis que l'analyse nécessite une agrégation multidimensionnelle souvent faite en BI.
* **Validation :** J'ai validé que cette explication concordait avec les concepts de mon cours sur la normalisation des bases de données et la nécessité d'un entrepôt de données.
* **Justification :** Cette interaction était nécessaire pour poser les bases théoriques du "Board Brief" et expliquer au CEO pourquoi une solution technique simple n'était pas immédiate.

---

### 2026-05-10 — Séance S01

* **Modèle :** Gemini 1.5 Flash
* **Prompt :** « et peut tu refaire les sections au complet du brief svp pour que ce soit claire, simple et logique »
* **Résultat :** L'IA a structuré un rapport professionnel complet incluant : Réponse exécutive, Obstacles concrets (24 tables), Modèle en étoile (Dimensions vs Faits) et Prochaines recommandations.
* **Validation :** J'ai ajusté la section "Preuve" pour inclure des données spécifiques à mon projet (255 clients, 534 commandes) et les résultats de mes requêtes SQL sur le chiffre d'affaires par région au Québec.
* **Justification :** Cette étape a permis de transformer des concepts techniques abstraits en un document de communication stratégique adapté à un haut dirigeant.

---

### 2026-05-10 — Séance S01

* **Modèle :** Gemini 1.5 Flash
* **Prompt :** « dans preuve jaimerais ajouter le fait des jointure et du temps et d'expliquer quon peut de facon compliquer avoir un réponse mais comme cest pas durable, ten pense quoi »
* **Résultat :** L'IA a proposé d'illustrer la "dette technique" en montrant qu'une requête SQL sur un OLTP nécessite des jointures multiples (JOIN) et des calculs de dates à la volée, ce qui est risqué et non automatisable.
* **Validation :** J'ai vérifié la structure de ma base de données `nexamart.duckdb` avec les commandes `DESCRIBE` pour m'assurer que les tables mentionnées (produits, magasins, géographie) existaient réellement.
* **Justification :** Interaction cruciale pour démontrer au "Board" que le projet de modélisation en étoile n'est pas un luxe, mais une nécessité pour garantir la fiabilité des données à long terme.


Séance 2 _____________________________________________________

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** jai ca comme erreur: [log SQLTools avec erreur DuckDB / duckdb-async / Cannot read properties of null (reading 'driver')]
- **Résultat :** L’IA a analysé l’erreur SQLTools et identifié que le problème venait du driver DuckDB pour SQLTools, plus précisément du module Node manquant `duckdb-async` et d’une incompatibilité probable avec Node.js 22.
- **Validation :** J’ai vérifié que le fichier `db/nexamart.duckdb` existait et que la connexion était bien configurée dans `.vscode/settings.json`. L’installation du module a échoué, confirmant le problème de compatibilité avec Node.js.
- **Justification :** Cette interaction était nécessaire pour comprendre pourquoi SQLTools ne pouvait pas ouvrir la base DuckDB dans VS Code.

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** faudrait que j'aille quoi comme node?
- **Résultat :** L’IA a recommandé d’utiliser Node.js 20 LTS au lieu de Node.js 22, car les dépendances natives du driver DuckDB sont plus compatibles avec Node 20.
- **Validation :** J’ai comparé cette recommandation avec le message d’erreur npm, qui indiquait que DuckDB n’avait pas de binaire compatible avec Node 22 et essayait de compiler localement.
- **Justification :** Cette interaction était nécessaire pour choisir une version de Node compatible avec SQLTools et DuckDB.

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** trouve moi une autre facon de lire du sql svp parce que cette facon marche pas
- **Résultat :** L’IA a proposé de contourner SQLTools et d’utiliser DuckDB directement avec Python dans le terminal VS Code. Elle a testé l’ouverture de `db/nexamart.duckdb` et confirmé que la base fonctionnait sans SQLTools.
- **Validation :** Une commande Python avec DuckDB a réussi à afficher la liste des tables de la base, ce qui a confirmé que la base elle-même fonctionnait correctement.
- **Justification :** Cette interaction était nécessaire pour continuer le travail SQL malgré le problème avec l’extension SQLTools.

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** je veux voir ca dans mon terminal, comment je fais? : SELECT ROW_NUMBER() OVER (ORDER BY channel_id) AS channel_key, channel_id, channel_name, channel_type FROM raw_dim_channel WHERE channel_id IS NOT NULL;
- **Résultat :** L’IA a fourni une commande PowerShell utilisant Python et DuckDB pour exécuter la requête SQL de `dim_channel.sql` dans le terminal.
- **Validation :** La première commande a produit une erreur PowerShell, puis une autre tentative a montré que `fetchdf()` nécessitait `numpy`, qui n’était pas installé dans l’environnement virtuel.
- **Justification :** Cette interaction était nécessaire pour apprendre à exécuter une requête SQL directement dans le terminal.

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** est tu capable de l'afficher sous forme de tableau dans le temrinal et non avec des virgule?
- **Résultat :** L’IA a fourni un script PowerShell/Python qui exécute le fichier SQL et affiche le résultat sous forme de tableau aligné dans le terminal, sans utiliser `pandas` ou `numpy`.
- **Validation :** La solution évite `fetchdf()` et utilise plutôt `fetchall()`, ce qui règle le problème de dépendance manquante.
- **Justification :** Cette interaction était nécessaire pour rendre les résultats SQL plus lisibles dans le terminal.

### 2026-05-11 — Séance S02
- **Modèle :** Codex / ChatGPT
- **Prompt :** je veux voir ca dans le terminal : SELECT ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key, customer_id, first_name, last_name, first_name || ' ' || last_name AS full_name, email_domain, city, province, loyalty_segment, CAST(join_date AS DATE) AS join_date FROM raw_dim_customer WHERE customer_id IS NOT NULL;
- **Résultat :** L’IA a adapté la commande précédente pour lire et afficher `sql/dims/dim_customer.sql` sous forme de tableau dans le terminal, avec les 20 premières lignes.
- **Validation :** La commande lit directement le fichier SQL actif et limite l’affichage avec `fetchmany(20)` pour éviter un résultat trop long.
- **Justification :** Cette interaction était nécessaire pour inspecter le résultat de la dimension client sans utiliser SQLTools.
