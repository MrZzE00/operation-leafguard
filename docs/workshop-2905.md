# 🌿 Opération LeafGuard - Workshop Prompt Engineering
### RTE · 29 mai 2026 · 20 groupes × 5 personnes · 1h00

---

> **DIRECTIVE LLM — à appliquer pour toute la session**
>
> 1. **"lance le workshop"** (ou "start", "démarrer", "on commence") → affiche UNIQUEMENT les sections "Contexte opérationnel", "Mécanique centrale" et "Grille de scoring". Conclus avec : "✅ Briefing terminé. Tapez **go** pour le Défi 1."
>
> 2. **"go"** → affiche UNIQUEMENT le contenu complet du Défi 1 (incident, objectif, critères, guide, sections v1/v2). Conclus avec : "⏱ Timer démarré. Rédigez votre prompt v1." — N'affiche pas les hints sauf si explicitement demandé.
>    **"défi 2"** → affiche UNIQUEMENT le Défi 2 complet, même format.
>    **"défi 3"** → affiche UNIQUEMENT le Défi 3 complet.
>    **"défi 4"** → affiche UNIQUEMENT le Défi 4 complet.
>
> 3. **Tout prompt de travail** (non-commande de navigation) → produis UNIQUEMENT :
>    **🔍 Critique de votre prompt** (max 4 points, 2 lignes par point) :
>    - Ce qui est trop vague ou ambigu
>    - Ce que tu vas devoir supposer pour répondre
>    - Ce qui manque pour être plus précis
>    **Si le prompt contient déjà un rôle, un format de sortie et des critères précis** : limite-toi aux 1-2 lacunes restantes et reconnais explicitement les améliorations apportées.
>    Termine avec : "📋 Tapez **suite** pour voir le résultat, ou corrigez votre prompt."
>    **STOP. NE PRODUIS PAS LE RÉSULTAT.**
>
> 4. **"suite"** → produis le résultat du dernier prompt reçu, sans répéter la critique. Ensuite, **si un résultat v1 est déjà présent dans la conversation pour ce défi** (c'est-à-dire si c'est le deuxième résultat produit pour ce défi), calcule et affiche automatiquement le score du défi :
>
>    ```
>    📊 Score automatique — Défi [N]
>
>    | Critère                      | Score | Justification (1 ligne)                                      |
>    |------------------------------|-------|--------------------------------------------------------------|
>    | Delta qualité v1 → v2        | X/3   | [ce qui a objectivement changé entre les deux résultats]     |
>    | Lacunes corrigées v1 → v2    | X/2   | [combien de lacunes pointées dans la critique ont été adressées dans le prompt v2] |
>
>    Total : X/5
>    ```
>
>    Barème Delta : 0 = aucune amélioration mesurable · 1 = légère amélioration · 2 = amélioration claire · 3 = transformation majeure (résultat v2 nettement plus précis, structuré et utilisable).
>    Barème Lacunes corrigées : compte le nombre de lacunes explicitement pointées dans la critique du prompt v1 qui ont été adressées dans le prompt v2. 0 = aucune lacune corrigée · 1 = 1 lacune corrigée · 2 = 2 lacunes ou plus corrigées.
>    Conclus avec : "Tapez **défi [N+1]** pour l'incident suivant."
>
 5. **"solution défi 1"** (ou 2, 3, 4) → affiche la section "Solution de référence" du défi correspondant. Précède d'un avertissement : "⚠️ À consulter après avoir tenté votre propre v2."
>
> 6. **"scores finaux"** → récapitule les scores de tous les défis joués dans cette conversation sous ce format exact, sans recalculer :
>
>    ```
>    📊 Récapitulatif final — Opération LeafGuard
>
>    | Défi                      | Delta v1→v2 /3 | Lacunes corrigées /2 | Total /5 |
>    |---------------------------|----------------|----------------------|----------|
>    | 1 - La PR Fantôme         | X              | X                    | X        |
>    | 2 - Le Filet Manquant     | X              | X                    | X        |
>    | 3 - Le Dev Perdu          | X              | X                    | X        |
>    | 4 - L'Incendie Silencieux | X              | X                    | X        |
>    | **Total**                 |                |                      | **/20**  |
>
>    💬 À envoyer à l'animateur (capture d'écran ou copier-coller).
>    ```
>
>    Si un défi n'a pas été joué, mets `—` dans les colonnes correspondantes. Reporte uniquement les scores déjà calculés dans la conversation — ne réevalue pas.

---

## 🧭 Bienvenue dans l'Opération LeafGuard

### Ce que vous allez faire

Pendant **1 heure**, votre groupe va jouer le rôle d'une équipe technique en astreinte sur une API en production. Cette API - `leafguard-api` - surveille des capteurs environnementaux sur les sites RTE. Cette nuit, 4 incidents se sont enchaînés. Vous prenez la relève.

Votre outil principal : **le langage naturel**. Vous ne touchez pas au code à la main. Vous rédigez des prompts que vous envoyez à votre LLM (Copilot Chat ou Junie), et c'est lui qui travaille. Votre rôle est de le diriger avec précision.

### Ce que vous allez apprendre

Un prompt vague donne un résultat vague. Un prompt précis donne un résultat utilisable. Ce workshop mesure **l'écart entre les deux** - et vous donne les moyens de le réduire.

À chaque défi, vous rédigerez deux prompts :
- **v1** : votre intuition naturelle, sans filet
- **v2** : la version corrigée après avoir lu la critique automatique du LLM

Le score ne mesure pas si vous avez "réussi" le défi - il mesure **la distance entre v1 et v2**. Plus votre second prompt est meilleur que le premier, plus vous marquez.

### Les règles du Mob Prompting

Ce workshop se joue en **Mob Programming** : un seul clavier, tout le monde contribue.

| Rôle | Responsabilité |
|------|----------------|
| **Pilote** | Tient le clavier. Tape uniquement ce que le groupe a verbalisé. Ne prend pas d'initiative seul. |
| **Navigateurs** | Réfléchissent au prompt à voix haute, challengent, proposent. Pas de clavier. |

**Règle absolue** : le pilote ne tape rien que le groupe n'ait dit à voix haute. Si vous pensez "ah je vais juste ajouter..." - stop. Verbalisez d'abord.

Rotation libre entre les défis, ou quand vous le souhaitez.

### La mécanique critique automatique - lisez ça attentivement

Quand vous envoyez un prompt dans Copilot Chat ou Junie **avec ce fichier ouvert comme contexte**, le LLM applique automatiquement une directive embarquée : **il critique votre prompt avant de produire le résultat**.

Cela ressemble à ça :

```
🔍 Critique de votre prompt

- Ce qui est vague : vous demandez une "review" sans préciser le format attendu ni le niveau de sévérité souhaité.
- Ce que je vais devoir supposer : je vais choisir moi-même la structure du rapport et les critères d'évaluation.
- Ce qui améliorerait le résultat : précisez si vous voulez un tableau, une liste, un scoring...

[Résultat de votre prompt v1 suit ici]
```

**Le LLM s'arrête après la critique.** Il attend votre décision : tapez **`suite`** pour voir le résultat, ou ignorez-le et réécrivez directement votre prompt. C'est la matière première de votre prompt v2.

---

## ⚙️ Setup (⏱ 2 min)

```bash
git clone https://github.com/MrZzE00/operation-leafguard
cd operation-leafguard
chmod +x inject-defects.sh && ./inject-defects.sh
cd leafguard-api && mvn compile -q && echo "✅ BUILD OK"
```

> Build OK ? Importez le dossier `leafguard-api` dans IntelliJ (`File → Open`), attendez la fin de l'indexation, puis tapez **lance le workshop** dans Copilot Chat ou Junie avec ce fichier (`workshop-2905.md`) ouvert comme contexte.

---

## 🎯 Contexte opérationnel

`leafguard-api` est l'API Spring Boot de surveillance des capteurs environnementaux (température, humidité, CO2) déployée en urgence sur les sites RTE. Elle collecte des mesures en temps réel et déclenche des alertes si les seuils sont franchis.

Cette nuit, **4 incidents se sont enchaînés**. Votre groupe prend la relève.

---

## 🔑 Mécanique centrale - Le cycle Prompt v1 → v2

Chaque défi suit **5 étapes obligatoires**. Pas de raccourci.

| Étape | Action |
|-------|--------|
| **1** | Lire l'incident. Rédiger un **prompt v1** collectivement. L'envoyer dans votre outil LLM. |
| **2** | Le LLM critique automatiquement votre prompt **avant de produire le résultat** - sans action de votre part. |
| **3** | Lire la critique collectivement. Décider : corriger maintenant (→ prompt v2) ou voir le résultat d'abord. |
| **4** | Rédiger le **prompt v2** en corrigeant les faiblesses identifiées. L'exécuter. |
| **5** | Comparer le résultat v1 et le résultat v2. Évaluer le delta. |

> **Règle d'or** : aucun exemple de prompt dans ce document. C'est à vous de les construire. Les hints sont disponibles si vous êtes bloqués - mais utiliser un hint coûte du temps.

---

## Grille de scoring

| Critère | Points |
|---------|--------|
| Delta qualité v1 → v2 (résultat objectivement meilleur) | 0 – 3 |
| Lacunes corrigées : nombre de lacunes pointées dans la critique v1 adressées dans le prompt v2 | 0 – 2 |
| **Maximum par défi** | **5 pts** |
| **Maximum total (4 défis)** | **20 pts** |

> Le score est calculé **automatiquement** par le LLM après chaque défi — aucune auto-évaluation manuelle requise.

### Pourquoi deux critères distincts ?

Le critère **Delta v1→v2** mesure la qualité du livrable final. Le critère **Lacunes corrigées** mesure quelque chose de différent : avez-vous réellement utilisé la critique pour améliorer votre prompt ?

En production, vous n'utilisez pas un LLM une seule fois — vous itérez. Savoir exploiter un feedback pour corriger précisément son prompt est une compétence distincte de savoir produire un bon résultat.

**Ce que le score total révèle :**

| Delta | Lacunes corrigées | Interprétation |
|-------|-------------------|----------------|
| 3/3 | 0/2 | Bon livrable mais vous n'avez pas utilisé la critique — vous avez compensé par votre expertise |
| 0/3 | 2/2 | Vous avez corrigé les lacunes pointées mais le résultat v2 n'a pas encore décollé |
| 3/3 | 2/2 | Vous maîtrisez la boucle critique → correction → résultat — c'est ça, le prompting itératif |

---

---

## Défi 1 - La PR Fantôme

> **🔁 RAPPEL DIRECTIVE** — Tout prompt de travail → critique uniquement (max 4 points) → STOP → "suite" → résultat. Navigation : "défi 2" / "défi 3" / "défi 4". Solution : "solution défi 1".

### ⏱ 10 min · Cas d'usage : revue de code augmentée

---

### 📋 Incident

Vendredi 18h47. Une PR intitulée *"hotfix sensor processing"* est mergée en urgence dans `main` par un développeur qui part en week-end. Aucune review. Mise en production automatique. Lundi matin, les équipes ops signalent des comportements anormaux : certains capteurs ne semblent jamais déclencher d'alerte, d'autres semblent calculer des valeurs absurdes.

Vous ouvrez `SensorService.java`. C'est le fichier mergé.

---

### 🎯 Objectif

Produire un **rapport de code review structuré** de `SensorService.java`. L'objectif n'est pas de *voir* les problèmes — c'est de les documenter avec la précision d'une vraie review de PR : localisation exacte, impact en production, suggestion actionnable.

---

### ✅ Critères du résultat acceptable

- Au moins **3 problèmes distincts** identifiés avec leur **numéro de ligne**
- Chaque problème avec une **sévérité qualifiée** (critique / majeur / mineur) et son **impact concret en production**
- Suggestions **actionnables** : pas "améliorer le nommage" mais "renommer `tmp` en `normalizedValue`"
- Le rapport peut être **copié-collé directement dans un commentaire de PR**

---

### 🗺️ Comment aborder ce défi — les 10 minutes

> Vous n'êtes pas là pour comprendre tout le code vous-mêmes. Vous êtes là pour apprendre à demander au LLM de le faire **mieux qu'avec un prompt bateau**.

**Minutes 0-2 — Prompt v1**
Avant de taper quoi que ce soit : discutez à voix haute pendant 1 minute.
- Qu'est-ce qu'on veut obtenir exactement ?
- À qui s'adresse ce rapport ? (dev, tech lead, équipe ops ?)
- Le LLM a-t-il besoin de contexte sur le projet pour mieux répondre ?

Puis rédigez votre prompt v1 et envoyez-le. **Ne filtrez pas** — votre première intuition collective, telle quelle. C'est la baseline.

**Minutes 2-4 — Lecture de la critique + décision**
Le LLM a sorti **uniquement la critique** et s'est arrêté. Lisez-la collectivement.
- Qu'est-ce que le LLM dit qu'il a dû supposer ?
- Quelles informations lui manquaient ?
- Votre choix : taper **suite** pour voir le résultat v1 quand même, ou **réécrire le prompt directement**.

> Si vous tapez "suite" → vous obtenez le résultat v1. Comptez les problèmes détectés. Évaluez.

**Minutes 4-8 — Prompt v2**
Corrigez ce que la critique a pointé. Votre prompt v2 doit répondre aux lacunes identifiées.
Renvoyez-le au LLM. Le LLM critique à nouveau → tapez **suite** pour voir le résultat v2.

**Minutes 8-10 — Comparaison**
Comparez v1 et v2. Le score est calculé automatiquement par le LLM après votre "suite" v2.

---

### ✍️ Prompt v1 (min 0-3)

Rédigez collectivement votre premier prompt et envoyez-le dans Copilot Chat ou Junie avec `SensorService.java` visible ou collé.
Le LLM produit **uniquement la critique** et s'arrête. Lisez-la collectivement, puis tapez **suite** pour voir le résultat — ou repartez directement sur un prompt v2 amélioré.

---

### 🔄 Prompt v2 (min 5-9)

Lisez la critique. Identifiez les 1 à 3 lacunes principales. Corrigez-les dans votre prompt v2.
Exécutez. Comparez avec le v1.

---

### 💡 Hints — débloquez dans l'ordre si vraiment bloqués

<details>
<summary>Hint 1</summary>

Réfléchissez au **rôle** que vous donnez au LLM. Un LLM à qui on dit "lis ce code" et un LLM à qui on dit "tu es senior reviewer Java avec 10 ans d'expérience Spring Boot" ne répondent pas pareil.

</details>

<details>
<summary>Hint 2</summary>

Précisez le **format de sortie** : tableau avec colonnes, liste numérotée avec niveaux de sévérité, markdown... Un résultat structuré est plus facile à comparer entre v1 et v2.

</details>

<details>
<summary>Hint 3</summary>

Demandez explicitement de **distinguer** les problèmes de lisibilité (nommage, longueur) des problèmes de conception (responsabilités multiples, couplage, gestion des erreurs). Ce sont deux niveaux de risque différents.

</details>

<details>
<summary>💡 Solution de référence — à ouvrir après votre v2</summary>

**Prompt v2 de référence :**
```
Tu es un expert Java Spring Boot senior. Contexte : leafguard-api, API de surveillance de capteurs environnementaux, utilisée 24/7 en production. Stack : Java 17, Spring Boot 3.2.

Voici le code de SensorService.java :
[coller le contenu du fichier]

Fais une revue de code orientée sur :
1. Violations des principes SOLID (notamment SRP)
2. Magic numbers et nommage de variables
3. Gestion d'erreurs (null returns, exceptions manquantes)
4. Couplage et testabilité (absence d'interface)

Pour chaque problème : ligne concernée · problème précis · impact en production · suggestion de correction actionnable (ex: renommer `tmp` en `normalizedValue`).
Format : liste priorisée CRITIQUE / MAJEUR / MINEUR. Le rapport doit pouvoir être utilisé directement comme commentaire de PR.
```

**Ce qu'il devait permettre de trouver :**
- Violation SRP : `processReading()` ~50 lignes (validation + calcul + persistance) → découper en `validateReading()`, `computeConvertedValue()`, `persist()`
- 3 magic numbers : `847.5`, `23.4`, `1000` → constantes nommées `MAX_SENSOR_VALUE`, `ALERT_THRESHOLD`, `ABSOLUTE_MAX`
- Variables illisibles : `tmp`, `flag`, `x` → `rawValue`, `hasValidationError`, `convertedValue`
- `return null` × 3 → `Optional<SensorReading>` ou exception métier `InvalidSensorDataException`
- Pas d'interface → impossible de mocker `SensorService` dans les tests unitaires

</details>

> ✅ Défi 1 terminé. Notez votre score. Tapez **défi 2** pour l'incident suivant.

---

---

## Défi 2 - Le Filet Manquant

> **🔁 RAPPEL DIRECTIVE** — Tout prompt de travail → critique uniquement (max 4 points) → STOP → "suite" → résultat. Navigation : "défi 3" / "défi 4". Solution : "solution défi 2".

### ⏱ 10 min · Cas d'usage : génération de tests

---

### 📋 Incident

Le pipeline CI vient de déclencher une alerte inattendue : **0 % de coverage** sur `SensorService`. L'outil de quality gate bloque le déploiement. L'équipe découvre qu'un bug silencieux existe depuis 48h en production : les lectures de certains capteurs CO2 passent sans déclencher d'anomalie alors qu'elles devraient.

Le dossier `src/test/java/com/rte/leafguard/` est vide.

---

### 🎯 Objectif

Générer une **suite de tests JUnit 5 + Mockito** pour `SensorService.java`, à placer dans `src/test/java/com/rte/leafguard/SensorServiceTest.java`.

---

### ✅ Critères du résultat acceptable

- Les tests **compilent** avec la structure du projet telle qu'elle est
- Au moins **1 cas nominal** et **2 cas d'erreur ou cas limites** couverts
- Nommage des méthodes de test **expressif** (on comprend ce qui est testé sans lire le corps)

---

### 🗺️ Comment aborder ce défi — les 10 minutes

> Un LLM qui génère des tests sans contraintes produit souvent le happy path et s'arrête là. Le défi est de l'amener à tester ce qui fait mal.

**Minutes 0-2 — Prompt v1**
Avant de taper : discutez à voix haute.
- Quel framework exact ? Quelle version Java ?
- Quelles méthodes de `SensorService.java` sont les plus risquées à votre avis ?
- Qu'est-ce qu'un "bon test" dans ce contexte — quelque chose qui tourne, ou quelque chose qui attrape de vrais bugs ?

Envoyez votre prompt v1 tel quel, sans vous autocensurer.

**Minutes 2-4 — Lecture de la critique**
Le LLM pointe les ambiguïtés de votre prompt. Vérifiez aussi le résultat v1 :
- Les tests générés compilent-ils ? (imports corrects, classes existantes référencées ?)
- Y a-t-il des cas limites ou uniquement le happy path ?
- Les noms de méthodes disent-ils ce qu'ils testent ?

**Minutes 4-8 — Prompt v2**
Corrigez les lacunes identifiées. Soyez plus précis sur les cas à couvrir.
Renvoyez. Vérifiez que les tests compilent avec la structure générée lors du setup.

**Minutes 8-10 — Comparaison**
Comparez le nombre de cas couverts et leur pertinence. Le score est calculé automatiquement par le LLM après votre "suite" v2.

---

### ✍️ Prompt v1 (min 0-3)

Rédigez collectivement votre premier prompt et envoyez-le dans Copilot Chat ou Junie avec `SensorService.java` visible.
Le LLM produit **uniquement la critique** et s'arrête. Tapez **suite** pour voir le résultat, ou corrigez votre prompt directement.

---

### 🔄 Prompt v2 (min 5-9)

Lisez la critique. Corrigez les lacunes. Renvoyez.
Comparez le nombre de cas couverts et leur pertinence entre v1 et v2.

---

### 💡 Hints — débloquez dans l'ordre si vraiment bloqués

<details>
<summary>Hint 1</summary>

Précisez le **framework de test** attendu. "Génère des tests" peut produire JUnit 4, JUnit 5, TestNG, ou du pseudocode selon ce que le LLM choisit. Soyez explicite sur JUnit 5 + Mockito, et sur la version Spring Boot cible.

</details>

<details>
<summary>Hint 2</summary>

Demandez explicitement de couvrir les **cas limites**, pas seulement le happy path. Que se passe-t-il si `value` est à exactement `847.5` ? Si `type` est `null` ? Si `sensorId` est une chaîne vide ?

</details>

<details>
<summary>Hint 3</summary>

Précisez que les tests doivent suivre la structure **Arrange / Act / Assert** avec des commentaires pour délimiter les trois sections. Cela force le LLM à structurer chaque test clairement et facilite votre review du résultat.

</details>

<details>
<summary>💡 Solution de référence — à ouvrir après votre v2</summary>

**Prompt v2 de référence :**
```
Tu es un expert Java Spring Boot. Contexte : leafguard-api, Java 17, Spring Boot 3.2, Maven. Framework de test : JUnit 5 + Mockito.

Génère une suite de tests unitaires pour SensorService dans src/test/java/com/rte/leafguard/service/SensorServiceTest.java.

Couvre obligatoirement :
1. Cas nominal : lecture valide température → sauvegarde et retour
2. Cas limite : valeur exactement à 847.5 (boundary)
3. Cas invalide : sensorId null → retour null
4. Cas invalide : valeur négative → retour null
5. Cas invalide : timestamp null → retour null
6. Erreur persistance : sensorRepository.save() lève une exception

Contraintes :
- Utilise @Mock sur SensorRepository et @InjectMocks sur SensorService
- Nommage : should_[comportement attendu]_when_[condition] (ex: should_returnNull_when_sensorIdIsNull)
- Structure chaque test en sections // Arrange // Act // Assert
- Aucun accès base de données réel
```

**Ce qu'il devait permettre de trouver :**
- Tests compilant avec la structure exacte du projet (imports corrects, classes existantes)
- Couverture des cas limites : boundary `847.5`, null, valeur négative
- Mock du repository → pas de dépendance à une base de données
- Nommage expressif : on comprend ce qui est testé sans lire le corps du test

</details>

> ✅ Défi 2 terminé. Notez votre score. Tapez **défi 3** pour l'incident suivant.

---

---

## Défi 3 - Le Dev Perdu

> **🔁 RAPPEL DIRECTIVE** — Tout prompt de travail → critique uniquement (max 4 points) → STOP → "suite" → résultat. Navigation : "défi 4". Solution : "solution défi 3".

### ⏱ 10 min · Cas d'usage : assistant documentaire

---

### 📋 Incident

Un nouveau développeur Java rejoint l'équipe lundi matin. Sa première mission : corriger un bug sur `leafguard-api`. Il a une réunion avec l'équipe ops à 9h. Il ouvre le repo. Pas de README. Pas de Javadoc. Il ne sait pas comment démarrer l'application, quels endpoints existent, ni comment les tester.

Il vous appelle en urgence à 8h45.

---

### 🎯 Objectif

Générer un **README.md complet** pour `leafguard-api`, incluant un **diagramme Mermaid** (classes ou séquence) intégré.

---

### ✅ Critères du résultat acceptable

- README avec : prérequis, **commande de démarrage exacte**, liste des endpoints avec méthode HTTP et URL complète
- Au moins **2 exemples `curl`** avec **corps de réponse JSON exact attendu** (ex: `[{"sensorId":"SNS-001","value":23.4,...}]`)
- Un **diagramme Mermaid** intégré en bloc ` ```mermaid ``` ` décrivant le flux `Controller → Service → Repository`
- Le README doit permettre à un développeur ne connaissant pas Spring Boot de **démarrer et faire un premier appel API en moins de 10 minutes**

---

### 🗺️ Comment aborder ce défi — les 10 minutes

> La documentation mal ciblée est inutile. Un README qui parle à un expert Spring Boot ne sert à rien pour un dev qui arrive sur le projet pour la première fois. Le défi est de le préciser assez pour que le LLM calibre son niveau de détail.

**Minutes 0-2 — Prompt v1**
Avant de taper : discutez à voix haute.
- Qui est le lecteur exactement ? Quel niveau de connaissance technique supposez-vous ?
- Le README et la Javadoc dans le même prompt ou deux prompts séparés ?
- Qu'est-ce qu'un README "complet" pour ce projet — une page ? cinq pages ?

Envoyez votre prompt v1 tel quel.

**Minutes 2-4 — Lecture de la critique**
Vérifiez le résultat v1 :
- Le README explique-t-il comment démarrer l'application, ou juste ce qu'elle fait ?
- Y a-t-il des exemples `curl` utilisables ? Avec corps de réponse JSON attendu ?
- La Javadoc a-t-elle des balises `@param`, `@return`, `@throws` sur chaque méthode publique ?

**Minutes 4-8 — Prompt v2**
Corrigez les lacunes. Précisez l'audience, le format, le niveau de détail.
Renvoyez.

**Minutes 8-10 — Comparaison**
Le dev imaginaire de 8h45 pourrait-il démarrer l'app avec le README v1 ? Et avec le v2 ? Le score est calculé automatiquement par le LLM après votre "suite" v2.

---

### ✍️ Prompt v1 (min 0-3)

Rédigez collectivement votre premier prompt et envoyez-le dans Copilot Chat ou Junie, avec `SensorService.java` et `SensorController.java` visibles.
Le LLM produit **uniquement la critique** et s'arrête. Tapez **suite** pour voir le résultat, ou corrigez votre prompt directement.

---

### 🔄 Prompt v2 (min 5-9)

Lisez la critique. Corrigez les lacunes identifiées. Renvoyez.
Comparez la qualité et l'utilisabilité réelle du README v1 vs v2.

---

### 💡 Hints — débloquez dans l'ordre si vraiment bloqués

<details>
<summary>Hint 1</summary>

Précisez l'**audience cible** : développeur Java confirmé mais qui ne connaît pas Spring Boot, pas l'écosystème RTE, et qui arrive sur ce projet pour la première fois. Le niveau de détail attendu change radicalement selon l'audience.

</details>

<details>
<summary>Hint 2</summary>

Demandez des **exemples curl avec les réponses attendues**, pas juste les URLs. Un exemple curl sans corps de réponse n'aide pas quelqu'un à vérifier que son installation fonctionne.

</details>

<details>
<summary>Hint 3</summary>

Précisez le **format Javadoc** attendu : balises `@param` pour chaque paramètre, `@return` avec description du résultat, `@throws` si une exception est possible. Sans cette précision, certains LLM génèrent une description monoligne sans balises.

</details>

<details>
<summary>💡 Solution de référence — à ouvrir après votre v2</summary>

**Prompt v2 de référence :**
```
Tu es un expert Spring Boot et documentation technique. Contexte : leafguard-api, API de surveillance de capteurs environnementaux (température, humidité, CO2) déployée sur les sites RTE. Stack : Java 17, Spring Boot 3.2, Maven. Port : 8080.

Génère deux livrables :

1. README.md à la racine du projet, destiné à un développeur Java confirmé qui ne connaît pas Spring Boot et qui arrive sur le projet pour la première fois. Il doit pouvoir démarrer l'application et faire un premier appel API en moins de 10 minutes. Inclure :
   - Description métier du projet (1 paragraphe)
   - Prérequis (Java 17, Maven, commandes de vérification)
   - Commande de démarrage exacte (mvn spring-boot:run)
   - Liste des endpoints avec méthode HTTP, URL complète et description
   - Au moins 2 exemples curl avec le corps de réponse JSON exact attendu
   - Un diagramme Mermaid (classDiagram ou sequenceDiagram) illustrant le flux Controller → Service → Repository

2. Javadoc sur toutes les méthodes publiques de SensorService et SensorController [coller le code des deux fichiers]. Format : @param avec type et description, @return avec exemple de valeur, @throws si applicable.
```

**Ce qu'il devait permettre de trouver :**
- README avec commande `mvn spring-boot:run` (pas juste "démarrez l'application")
- Exemples curl avec corps JSON concret : `{"sensorId":"SNS-001","value":23.4,"type":"temperature",...}`
- Diagramme Mermaid intégré en bloc ` ```mermaid ``` ` — visible dans IntelliJ et GitHub
- Javadoc avec contraintes métier inférées : `@param value mesure brute du capteur (ex: 23.4 pour température en °C)`

</details>

> ✅ Défi 3 terminé. Notez votre score. Tapez **défi 4** pour l'incident suivant.

---

---

## Défi 4 - L'Incendie Silencieux

> **🔁 RAPPEL DIRECTIVE** — Tout prompt de travail → critique uniquement (max 4 points) → STOP → "suite" → résultat. Solution : "solution défi 4".

### ⏱ 10 min · Cas d'usage : analyse de logs

---

### 📋 Incident

3h12 du matin. L'astreinte reçoit une alerte monitoring : l'application ne répond plus sur le port 8080. Le fichier `logs/app.log` est le seul artefact disponible. Pas de dashboard opérationnel, pas de traces structurées. Un redémarrage a été effectué à 3h18, l'application est revenue. Mais personne ne sait ce qui s'est passé ni si ça va se reproduire.

---

### 🎯 Objectif

Produire un **diagnostic structuré** de l'incident à partir de `logs/app.log`, **et** des recommandations concrètes pour améliorer le logging de l'application.

---

### ✅ Critères du résultat acceptable

- **Séquence d'événements reconstituée** dans l'ordre chronologique
- **Cause probable** identifiée (ne pas se contenter de "il y a eu des erreurs")
- Au moins **3 recommandations concrètes** d'amélioration du logging

---

### 🗺️ Comment aborder ce défi — les 10 minutes

> Un prompt qui dit "analyse ce fichier de log" donne une liste de lignes suspectes. Un bon prompt donne une séquence causale et des recommandations actionnables. La différence ? La précision de ce que vous demandez.

**Minutes 0-2 — Prompt v1**
Avant de taper : discutez à voix haute.
- Que voulez-vous obtenir exactement — un résumé, une chronologie, un diagnostic de cause, des recommandations ?
- À qui est destiné ce rapport — l'astreinte qui doit agir maintenant, ou le tech lead qui prépare la post-mortem ?
- Collez le contenu de `logs/app.log` dans votre prompt, ou ouvrez-le dans l'outil.

Envoyez votre prompt v1 tel quel.

**Minutes 2-4 — Lecture de la critique**
Vérifiez le résultat v1 :
- Y a-t-il une reconstitution chronologique des événements ou une liste en vrac ?
- La "cause probable" est-elle identifiée avec précision (quelle exception, quelle ligne de code) ?
- Les recommandations sont-elles concrètes avec des exemples avant/après, ou génériques ?

**Minutes 4-8 — Prompt v2**
Corrigez les lacunes. Demandez explicitement ce qui manquait.
Renvoyez.

**Minutes 8-10 — Comparaison**
L'astreinte de 3h12 aurait-elle pu agir sur la base du diagnostic v1 en moins de 5 minutes ? Et avec le v2 ? Le score est calculé automatiquement par le LLM après votre "suite" v2.

---

### ✍️ Prompt v1 (min 0-3)

Rédigez collectivement votre premier prompt. Collez le contenu de `logs/app.log` dans votre outil LLM ou ouvrez-le comme contexte.
Le LLM produit **uniquement la critique** et s'arrête. Tapez **suite** pour voir le résultat, ou corrigez votre prompt directement.

---

### 🔄 Prompt v2 (min 5-9)

Lisez la critique. Corrigez les lacunes. Renvoyez.
Comparez la précision du diagnostic et l'utilisabilité des recommandations entre v1 et v2.

---

### 💡 Hints — débloquez dans l'ordre si vraiment bloqués

<details>
<summary>Hint 1</summary>

Demandez une **reconstitution chronologique** explicitement. Sans cette instruction, le LLM peut vous sortir une synthèse thématique qui mélange les événements. La chronologie est ce qui permet de comprendre la causalité.

</details>

<details>
<summary>Hint 2</summary>

Précisez que vous voulez savoir ce qu'on **aurait dû logger** pour pouvoir diagnostiquer cet incident en moins de 5 minutes. Cette contrainte force le LLM à raisonner sur les informations manquantes, pas seulement sur ce qui est présent.

</details>

<details>
<summary>Hint 3</summary>

Demandez des **exemples de messages de log améliorés** au format avant / après, pour au moins 2 des erreurs présentes dans le fichier. Un exemple concret vaut mieux qu'une recommandation abstraite sur "les logs doivent être plus informatifs".

</details>

<details>
<summary>💡 Solution de référence — à ouvrir après votre v2</summary>

**Prompt v2 de référence :**
```
Tu es un expert Java Spring Boot en astreinte. Contexte : leafguard-api (surveillance capteurs RTE), Java 17, Spring Boot 3.2, SLF4J pour le logging. L'application vient de tomber à 3h12 et a été redémarrée à 3h18.

Voici le contenu de logs/app.log :
[coller le contenu du fichier]

Produis un diagnostic structuré en deux parties :

PARTIE 1 — Reconstitution chronologique des événements : liste les événements dans l'ordre, identifie la cause probable (quelle exception, quelle ligne de code, quel état inattendu a provoqué la chute).

PARTIE 2 — Anti-patterns de logging identifiés et recommandations : pour chaque problème de logging trouvé, donne un exemple avant/après concret. L'objectif : qu'un ingénieur d'astreinte puisse diagnostiquer un incident similaire en moins de 5 minutes.

Audience : l'ingénieur d'astreinte doit pouvoir agir sur PARTIE 1 dans les 5 prochaines minutes. Le tech lead utilisera PARTIE 2 pour la post-mortem.
```

**Ce qu'il devait permettre de trouver :**
- Séquence causale : NPE dans `processReading()` sur `tmp`/`flag` → cascade d'erreurs → crash à 3h18
- Anti-patterns : `e.printStackTrace()` → perte contexte, `"Error occurred"` → sans information utile, pas de corrélation ID
- Exemples avant/après : `log.error("Error occurred")` → `log.error("Sensor reading failed for sensorId={}, value={}", sensorId, value, e)`
- Recommandation MDC pour corrélation ID de requête

</details>

> ✅ Défi 4 terminé. Notez votre score dans le tableau ci-dessous et attendez le signal de l'animateur.

---

---

## 🏁 Scoring final (⏱ 7 min)

### Score de votre groupe

Tapez **`scores finaux`** dans votre outil LLM pour obtenir le récapitulatif complet des 4 défis.
Envoyez le résultat à l'animateur (capture d'écran ou copier-coller).

> Le score est communiqué à l'animateur en fin de session. Il collecte les totaux de chaque groupe pour le classement global.

---

### Débrief collectif

L'animateur lit **2 à 3 prompts v2** issus de différents groupes (anonymisés).

**Question d'amorce :**

> "Qu'est-ce qui a changé entre votre prompt v1 et votre prompt v2 ?  
> Était-ce une question de rôle donné au LLM, de format demandé, de précision du contexte, de cas limites spécifiés ?"

---

---

## 📋 Cheat Sheet — Les 4 réflexes du prompting

> À afficher sur le vidéoprojecteur pendant le débrief collectif.

| Réflexe | Prompt vague ❌ | Prompt précis ✅ |
|---------|---------------|----------------|
| **Contexte** | "Fais une revue de code" | "Tu es senior reviewer Java Spring Boot, API en production 24/7, criticité élevée..." |
| **Objectif précis** | "Trouve les problèmes" | "Identifie violations SOLID, magic numbers, null returns — avec numéro de ligne" |
| **Format de sortie** | *(rien)* | "Liste priorisée CRITIQUE/MAJEUR/MINEUR, chaque item : ligne · problème · impact · suggestion" |
| **Audience** | *(rien)* | "Pour un développeur qui rejoint l'équipe lundi matin et ne connaît pas le projet" |

> **La règle d'or** : un LLM répond à ce que vous lui donnez. Contexte + objectif + format = résultat utilisable.

---

*🌿 Opération LeafGuard - Workshop RTE 29/05/2025*
