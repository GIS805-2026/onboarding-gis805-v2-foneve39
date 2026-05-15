# Rétroaction automatisée -- S01 (Diagnostic fondamental -- NexaMart kickoff)

_Générée le 2026-05-15T12:39:30+00:00 -- Run `20260515T122624Z-00a5a04f`_

Ce document est produit par un pipeline reproductible (vérification SQL déterministe + analyse LLM du brief et de la déclaration IA). Une revue humaine précède toujours sa publication. **À ce stade expérimental, aucune note ni étiquette de niveau n'est diffusée : l'objectif est purement formatif.**

> ⚠️ **Avertissement instructeur (à retirer avant publication) :** cette analyse a été générée avec `--skip-pull`. Le contenu correspond au commit local et **n'est peut-être pas la dernière version poussée par l'étudiant·e**.

---

## 1. Vérification automatique de la requête SQL

La requête extraite de votre brief n'a pas pu être validée automatiquement. Quelques pistes constructives ci-dessous pour vous aider à la rendre exécutable et alignee avec la question posée.

_Observation technique : aucun bloc SQL fencé trouvé et extraction LLM échouée_


**Pistes :**
> Aucun bloc ```sql ... ``` détecté. Encadrez votre requête finale dans la section « Preuve » pour fiabiliser l'auto-validation.
> Extracteur LLM : Aucune des requêtes présentes ne regroupe simultanément par category, region et quarter : il y a une requête par category+region et une autre par region seulement, mais aucune n'inclut le trimestre demandé.

## 2. Rétroaction pédagogique sur le brief

> Bon diagnostic business : le brief explique clairement pourquoi l'approche OLTP est insuffisante et recommande un schéma en étoile. Il manque cependant des détails techniques clés (grain, SCD) et des checks reproductibles pour mettre la solution en production.

### Observations par dimension

**Model quality**
- Observation : Le brief propose un schéma en étoile avec Fact: Sales et dimensions Product/Region/Date, mais n'énonce pas explicitement le grain (ligne de commande vs commande) et omet des détails SCD.
- Piste d'amélioration : Préciser le grain (ex. : order_id + product_id), détailler les attributs des dimensions et justifier le pattern SCD choisi (type 1 vs type 2).

**Validation quality**
- Observation : Le document montre des requêtes et des checks DuckDB (counts, agrégats par région) qui s'exécutent, mais sans gestion explicite des cas limites (NULLs, doublons de grain).
- Piste d'amélioration : Ajouter des contrôles automatisés (make check) traitant NULLs, doublons de grain et vérifications de conservation (ex. somme des ventes).

**Executive justification**
- Observation : Le brief répond au CEO en langage business: la solution actuelle est artisanale et il recommande de transformer les 24 tables en un modèle décisionnel (schéma en étoile) pour permettre l'analyse des tendances.
- Piste d'amélioration : Préciser la décision demandée au CEO (p.ex. budget/ressources et calendrier minimal pour livrer S02) pour faciliter l'approbation immédiate.

**Process trace**
- Observation : Le brief inclut commandes DuckDB et exemples SQL mais n'indique pas d'historique git ni de note détaillée sur l'usage d'IA ou validation humaine.
- Piste d'amélioration : Fournir un historique git avec ≥3 commits significatifs et une note IA précisant outils utilisés et validations humaines.

**Reproducibility**
- Observation : Le brief montre commandes DuckDB avec un chemin de base (db/nexamart.duckdb) mais n'inclut pas de script unique ou README garantissant une reproduction sans ajustement.
- Piste d'amélioration : Ajouter un script 'make run' ou 'run_checks.sh' et un README décrivant exactement comment cloner, exécuter et obtenir les mêmes résultats.

## 3. Déclaration d'utilisation de l'IA

> La déclaration décrit clairement les interactions IA, les étapes d'utilisation, et les validations humaines, et mentionne plusieurs erreurs rencontrées. Cependant quelques usages sont formulés de façon générique (ex. «Codex / ChatGPT» sans version précise), ce qui empêche d'atteindre la note maximale.

**Sujets bien couverts dans votre déclaration :**

- outils utilisés (nom + version/modèle)
- à quelle étape l'IA a été utilisée
- comment la sortie a été validée par l'humain
- limites ou erreurs observées

## 4. Pistes d'action pour la prochaine itération

- Reprendre la requête de la section « Preuve » pour qu'elle s'exécute sur `db/nexamart.duckdb` et qu'elle produise la forme attendue (voir pistes en section 1).

---

## 5. Traçabilité

- **Run ID :** `20260515T122624Z-00a5a04f`
- **Devoir :** `S01`
- **Étudiant·e :** `foneve39`
- **Commit analysé :** `7808dd1`
- **Audit (côté instructeur) :** `tools/instructor/feedback_pipeline/audit/20260515T122624Z-00a5a04f/foneve39/`
- **Prompts (SHA-256) :**
  - `sql_extractor_system` : `90ee9e277de7a27f...`
  - `rubric_grader_system` : `505f32d1d8319d66...`
  - `ai_usage_grader_system` : `81cb7fdf89bda55a...`
- **Fournisseur (rubrique) :** `openai`
- **Fournisseur (IA-usage) :** `openai` (gpt-5-mini-2025-08-07)

_Ce feedback a été produit par un pipeline automatisé et **revu par l'équipe pédagogique avant publication**. Aucun chiffre ni étiquette de niveau n'est diffusé à ce stade expérimental : l'objectif est uniquement formatif. Ouvrez une issue dans ce dépôt pour toute question._
