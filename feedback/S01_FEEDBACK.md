# Rétroaction automatisée -- S01 (Diagnostic fondamental -- NexaMart kickoff)

_Générée le 2026-05-15T12:54:54+00:00 -- Run `20260515T125138Z-ff34aff5`_

Ce document est produit par un pipeline reproductible (vérification SQL déterministe + analyse LLM du brief et de la déclaration IA). Une revue humaine précède toujours sa publication. **À ce stade expérimental, aucune note ni étiquette de niveau n'est diffusée : l'objectif est purement formatif.**

> ⚠️ **Avertissement instructeur (à retirer avant publication) :** cette analyse a été générée avec `--skip-pull`. Le contenu correspond au commit local et **n'est peut-être pas la dernière version poussée par l'étudiant·e**.

---

## 1. Vérification automatique de la requête SQL

La requête extraite de votre brief n'a pas pu être validée automatiquement. Quelques pistes constructives ci-dessous pour vous aider à la rendre exécutable et alignee avec la question posée.

_Observation technique : SQL détecté mais aucune requête ne satisfait l'énoncé_


**Pistes :**
> L'extracteur LLM a inspecté vos requêtes mais aucune ne répond à la question (dimensions/colonnes attendues manquantes).
> Extracteur LLM : Aucune des requêtes présentes ne produit les colonnes attendues (category, region, quarter) : on trouve une requête groupée par region+category et une autre par region seulement, mais aucune n'agrège par trimestre (quarter).

## 2. Rétroaction pédagogique sur le brief

> Le brief identifie bien les limitations de l'OLTP et propose un passage au schéma en étoile, avec preuves SQL partielles. Il manque cependant des éléments cruciaux : grain explicite, contrôles automatisés et traçabilité git pour rendre la livraison exploitable en production.

### Observations par dimension

**Model quality**
- Observation : Le brief propose un schéma en étoile (Fact: Sales, Dimensions: Product, Region/Store, Date) mais n'énonce pas clairement le grain (ligne de commande vs commande) ni les règles SCD.
- Piste d'amélioration : Préciser explicitement le grain (ex. 'une ligne = ligne de commande order_line') et détailler le traitement SCD attendu (Type 2 vs Type 1) pour chaque dimension.

**Validation quality**
- Observation : Le document inclut des requêtes DuckDB montrant des comptes (clients, commandes, produits) et un exemple SQL d'agrégation par région et catégorie.
- Piste d'amélioration : Ajouter des checks automatisés (NULLs sur clés dimensionnelles, doublons du grain) et gérer au moins un cas limite (valeurs NULL ou prix non-additifs) dans les requêtes de validation.

**Executive justification**
- Observation : La réponse exécutive dit clairement que le système actuel ne permet pas d'analyser les tendances et recommande la transformation des données brutes en modèle décisionnel.
- Piste d'amélioration : Formuler une recommandation décisionnelle chiffrée et priorisée (ex. effort estimé, gains attendus, KPI à suivre) pour que le CEO puisse valider l'action suivante.

**Process trace**
- Observation : Le brief montre des commandes DuckDB et des requêtes exécutées mais n'inclut aucune trace de commits git ni de note sur l'usage d'IA ou validation humaine.
- Piste d'amélioration : Ajouter un journal de commits incrémentaux (≥3) avec messages descriptifs et une note IA précisant outils utilisés et contrôles humains effectués.

**Reproducibility**
- Observation : Le document fournit des commandes DuckDB et chemins (ex. db/nexamart.duckdb) mais sans README détaillant les prérequis ou éviter les chemins codés en dur.
- Piste d'amélioration : Inclure un README reproduisible (Clone → dépendances → commande 'make check') et éviter les chemins codés en dur pour permettre une exécution sur un clone propre.

## 3. Déclaration d'utilisation de l'IA

> La déclaration couvre les interactions IA, les étapes où elles ont été utilisées, les vérifications humaines et plusieurs erreurs rencontrées. Certaines mentions d'outils sont un peu génériques (ex. « Codex / ChatGPT » sans version précise), d'où une note de 3 plutôt que 4.

**Sujets bien couverts dans votre déclaration :**

- outils utilisés (nom + version/modèle)
- à quelle étape l'IA a été utilisée
- comment la sortie a été validée par l'humain
- limites ou erreurs observées

## 4. Pistes d'action pour la prochaine itération

- Reprendre la requête de la section « Preuve » pour qu'elle s'exécute sur `db/nexamart.duckdb` et qu'elle produise la forme attendue (voir pistes en section 1).

---

## 5. Traçabilité

- **Run ID :** `20260515T125138Z-ff34aff5`
- **Devoir :** `S01`
- **Étudiant·e :** `foneve39`
- **Commit analysé :** `7808dd1`
- **Audit (côté instructeur) :** `tools/instructor/feedback_pipeline/audit/20260515T125138Z-ff34aff5/foneve39/`
- **Prompts (SHA-256) :**
  - `sql_extractor_system` : `90ee9e277de7a27f...`
  - `rubric_grader_system` : `505f32d1d8319d66...`
  - `ai_usage_grader_system` : `81cb7fdf89bda55a...`
- **Fournisseur (rubrique) :** `openai`
- **Fournisseur (IA-usage) :** `openai` (gpt-5-mini-2025-08-07)

_Ce feedback a été produit par un pipeline automatisé et **revu par l'équipe pédagogique avant publication**. Aucun chiffre ni étiquette de niveau n'est diffusé à ce stade expérimental : l'objectif est uniquement formatif. Ouvrez une issue dans ce dépôt pour toute question._
