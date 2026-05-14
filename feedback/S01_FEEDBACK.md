# Rétroaction automatisée -- S01 (Diagnostic fondamental -- NexaMart kickoff)

_Générée le 2026-05-14T22:26:01+00:00 -- Run `20260514T221333Z-7d34bf6a`_

Ce document est produit par un pipeline reproductible (vérification SQL déterministe + analyse LLM du brief et de la déclaration IA). Une revue humaine précède toujours sa publication. **À ce stade expérimental, aucune note ni étiquette de niveau n'est diffusée : l'objectif est purement formatif.**

---

## 1. Vérification automatique de la requête SQL

La requête extraite de votre brief n'a pas pu être validée automatiquement. Quelques pistes constructives ci-dessous pour vous aider à la rendre exécutable et alignee avec la question posée.

_Observation technique : erreur d'exécution SQL: Binder Error: Table "s" does not have a column named "zip_code"_

<details><summary>Requête analysée — cliquez pour déplier</summary>

```sql
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
```

</details>


**Pistes :**
> Requête extraite par LLM (aucun bloc fencé détecté). Encadrez votre requête finale par ```sql ... ``` pour éliminer toute ambiguïté.
> Votre `db/nexamart.duckdb` est absente ou vide ; la requête a été exécutée contre une **base de référence cohorte** (seed instructeur). Les chiffres retournés ne correspondent donc pas à vos propres données : reconstruisez votre base avec `python src/run_pipeline.py` (ou `.\run.ps1 load`) pour valider vos calculs sur votre seed personnel.
> Tables référencées dans votre requête mais absentes de la base : `raw_order_lines`, `raw_orders`.
> Tables disponibles dans `db/nexamart.duckdb` : `raw_bridge_campaign_allocation`, `raw_bridge_customer_segment`, `raw_customer_changes`, `raw_customer_profile_bands`, `raw_customer_scd3_history`, `raw_dim_channel`, `raw_dim_customer`, `raw_dim_date`, `raw_dim_geography`, `raw_dim_product`, `raw_dim_segment_outrigger`, `raw_dim_store`, `raw_fact_budget`, `raw_fact_daily_inventory`, `raw_fact_inventory_snapshot`, `raw_fact_order_pipeline`, `raw_fact_orders_transaction`, `raw_fact_promo_exposure`, `raw_fact_returns`, `raw_fact_sales`.

## 2. Rétroaction pédagogique sur le brief

> Bon diagnostic exécutif et justification claire de la nécessité d'un schéma en étoile; la démonstration SQL montre que la requête s'exécute aujourd'hui mais il manque des contrôles qualité systématiques et une traçabilité git. Pour améliorer : formaliser le grain, ajouter checks de qualité (NULLs, doublons, unit_price) et fournir un journal de commits + README reproductible.

### Observations par dimension

**Model quality**
- Observation : Vous proposez « Faire un schéma en étoile : Fact : Sales; Dimensions : Product, Region ou Store, date » mais le grain n'est pas formalisé (ligne de commande vs commande entière) et les patterns SCD ne sont pas explicitement appliqués.
- Piste d'amélioration : Préciser le grain exact (ex. order_id + product_id), documenter le pattern SCD à utiliser (Type 2) et fournir un DDL minimal pour fact_sales + dims.

**Validation quality**
- Observation : Vous montrez des contrôles (counts) et une requête SQL d'agrégation exécutée contre duckdb pour « Ventes par région », démontrant que la requête s'exécute.
- Piste d'amélioration : Ajouter des checks de qualité (NULLs sur product/category, doublons du grain) et traiter explicitement les cas limites (valeurs manquantes, unit_price non-additif).

**Executive justification**
- Observation : La réponse exécutive indique clairement que le système actuel n'est pas adapté, énumère les obstacles concrets et recommande de transformer les données en modèle décisionnel — décision actionnable pour le CEO.
- Piste d'amélioration : Renforcer la recommandation avec un résultat attendu chiffré (ex. gain de performance ou délai de mise en place estimé) pour faciliter la décision.

**Process trace**
- Observation : Vous incluez quelques commandes shell/duckdb montrant exploration, mais il n'y a aucune trace de commits git ni de note sur l'usage d'IA ou validation humaine.
- Piste d'amélioration : Fournir un historique de commits git (≥3 commits significatifs) et une note IA décrivant outils et validations humaines réalisées.

**Reproducibility**
- Observation : Vous fournissez des commandes duckdb et chemins (db/nexamart.duckdb) qui aident la reproduction, mais certains chemins et valeurs sont codés ou redacted, pas de README d'exécution complet.
- Piste d'amélioration : Ajouter un README avec étapes « clone → duckdb → make check » sans chemins codés en dur et inclure les scripts de test pour obtenir les mêmes résultats.

## 3. Déclaration d'utilisation de l'IA

> La déclaration couvre bien les quatre sujets demandés avec des exemples concrets et des validations réalisées. Toutefois, certaines mentions d'outils restent génériques (p. ex. « Codex / ChatGPT » sans version précise), ce qui empêche d'atteindre la note maximale.

**Sujets bien couverts dans votre déclaration :**

- outils utilisés (nom + version/modèle)
- à quelle étape l'IA a été utilisée
- comment la sortie a été validée par l'humain
- limites ou erreurs observées

## 4. Pistes d'action pour la prochaine itération

- Reprendre la requête de la section « Preuve » pour qu'elle s'exécute sur `db/nexamart.duckdb` et qu'elle produise la forme attendue (voir pistes en section 1).

---

## 5. Traçabilité

- **Run ID :** `20260514T221333Z-7d34bf6a`
- **Devoir :** `S01`
- **Étudiant·e :** `foneve39`
- **Commit analysé :** `3a30e22`
- **Audit (côté instructeur) :** `tools/instructor/feedback_pipeline/audit/20260514T221333Z-7d34bf6a/foneve39/`
- **Prompts (SHA-256) :**
  - `sql_extractor_system` : `90ee9e277de7a27f...`
  - `rubric_grader_system` : `505f32d1d8319d66...`
  - `ai_usage_grader_system` : `81cb7fdf89bda55a...`
- **Fournisseur (rubrique) :** `openai`
- **Fournisseur (IA-usage) :** `openai` (gpt-5-mini-2025-08-07)

_Ce feedback a été produit par un pipeline automatisé et **revu par l'équipe pédagogique avant publication**. Aucun chiffre ni étiquette de niveau n'est diffusé à ce stade expérimental : l'objectif est uniquement formatif. Ouvrez une issue dans ce dépôt pour toute question._
