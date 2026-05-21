# 🌿 Opération LeafGuard - Feuille Animateur

> Workshop gamifié · Prompting IA avec GitHub Copilot / Junie  
> Mob Programming · ~100 développeurs Java RTE · **1h00**  
> NDA RTE — usage interne Zenika uniquement

---

## 📋 Sommaire

1. [Vue d'ensemble](#1-vue-densemble)
2. [Prework — avant le jour J](#2-prework--avant-le-jour-j)
3. [Mécanique centrale — Le flow v1→v2](#3-mécanique-centrale--le-flow-v1v2)
4. [Guide défi par défi](#4-guide-défi-par-défi)
5. [Grille de scoring détaillée](#5-grille-de-scoring-détaillée)
6. [Commandes LLM disponibles](#6-commandes-llm-disponibles)
7. [Conseils d'animation](#7-conseils-danimation)
8. [FAQ technique](#8-faq-technique)

---

## 1. Vue d'ensemble

### 🎯 Objectifs pédagogiques

À la fin du workshop, chaque groupe doit être capable de :

1. **Rédiger un prompt contextualisé** — fournir au LLM le contexte métier, technique, et le format de sortie attendu
2. **Pratiquer le méta-prompting** — demander au LLM d'analyser et critiquer ses propres prompts pour les améliorer
3. **Mesurer le delta qualité** — identifier concrètement ce qui distingue un prompt faible d'un prompt fort
4. **Éviter le cargo cult prompting** — comprendre pourquoi copier un prompt d'autrui sans le comprendre ne fonctionne pas

### ⏱️ Timing minute par minute

| Temps | Durée | Activité | Animateur |
|-------|-------|----------|-----------|
| T-5 | 5 min | **Setup** — git clone + inject-defects.sh + mvn compile. Attendre `✅ BUILD OK` sur tous les postes | Donner l'URL du repo, circuler |
| T+0 | 10 min | **Intro narrative** — mise en contexte "Opération LeafGuard", règles du jeu, explication du flow v1→v2 | À l'oral, à partir de cette feuille |
| T+10 | 10 min | **Défi 1** — La PR Fantôme (revue de code) | Lancer le timer, circuler |
| T+20 | 2 min | **Inter-défi** — comparaison rapide 2 groupes, transition | Prendre 2 exemples de prompts v2 |
| T+22 | 10 min | **Défi 2** — Le Filet Manquant (tests) | Lancer le timer, circuler |
| T+32 | 2 min | **Inter-défi** | |
| T+34 | 10 min | **Défi 3** — Le Dev Perdu (documentation + Mermaid) | Lancer le timer, circuler |
| T+44 | 2 min | **Inter-défi** | |
| T+46 | 10 min | **Défi 4** — L'Incendie Silencieux (logs) | Lancer le timer, circuler |
| T+56 | 2 min | **Clôture des défis** — groupes tapent `scores finaux` dans leur outil LLM | |
| T+58 | 12 min | **Débrief collectif** — cheat sheet, questions de synthèse, classement | Afficher la cheat sheet |
| **Total** | **~70 min** | | |

> Le setup (git clone + inject-defects.sh + import IntelliJ) se fait **en séance à T-5**, avant l'intro narrative.

### 🗂️ Ce que l'animateur doit préparer avant le jour J

**Prérequis techniques (à vérifier sur chaque poste en amont) :**
- [ ] **Java 17+** installé (`java -version`)
- [ ] **Maven 3.6+** installé (`mvn -version`)
- [ ] **IntelliJ IDEA** avec **GitHub Copilot** activé (licence d'équipe) et/ou **Junie** installé
- [ ] Accès réseau vérifié (git clone vers GitHub)

**Logistique salle :**
- [ ] Distribuer (email, QR code, vidéoprojecteur) l'URL du repo : `https://github.com/MrZzE00/operation-leafguard`
- [ ] Distribuer le fichier `getting-started.md` à chaque groupe **avant** le J (optionnel — le repo le contient)
- [ ] Préparer un timer visible par tous (affichage projeté ou application timer)
- [ ] Préparer la collecte des scores (papier ou feuille partagée)
- [ ] Avoir la cheat sheet prête à afficher au vidéoprojecteur (section `## 📋 Cheat Sheet` du workshop-2905.md)

**Connaissance du projet :**
- [ ] Lire les imperfections volontaires (section 4) — elles sont connues de l'animateur **uniquement**
- [ ] Pratiquer le flow v1→v2 soi-même sur au moins un défi avant le jour J
- [ ] Préparer 2-3 exemples de "bons prompts v2" à montrer si aucun groupe ne trouve

**Règle fondamentale à annoncer dès l'intro :**
> "Vous ne tapez pas de code. Vous tapez uniquement des prompts. C'est l'IA qui travaille — vous, vous dirigez."

---

## 2. Setup — en séance (⏱ 2-5 min)

> Le setup se fait **en séance**, au signal de l'animateur. Distribuez l'URL du repo public avant de lancer le timer.

Donnez à chaque groupe l'URL : **`https://github.com/MrZzE00/operation-leafguard`**

Chaque groupe :
1. Clone le repo et exécute le script d'injection :
   ```bash
   git clone https://github.com/MrZzE00/operation-leafguard
   cd operation-leafguard
   chmod +x inject-defects.sh && ./inject-defects.sh
   cd leafguard-api && mvn compile -q && echo "✅ BUILD OK"
   ```
2. Importe `leafguard-api` dans IntelliJ (`File → Open` → sélectionner le dossier `leafguard-api`)
3. Vérifie que le build passe — `✅ BUILD OK` doit s'afficher

> Attendez que tous les groupes affichent `✅ BUILD OK` avant de lancer le workshop.

En cas d'échec : voir section [FAQ technique](#8-faq-technique).

---

## 3. Mécanique centrale — Le flow v1→v2

### Concept

Le workshop repose sur une boucle d'amélioration en 5 étapes que chaque groupe répète à chaque défi :

```
┌─────────────────────────────────────────────────────────────┐
│                    FLOW v1 → v2                             │
│                                                             │
│  1. LIT le problème                                         │
│  2. RÉDIGE un prompt v1 (intuition naturelle)               │
│  3. ENVOIE dans Copilot / Junie                             │
│  4. Le LLM critique le prompt AVANT de produire le résultat │
│     → ce qui est vague, ce qu'il va devoir supposer        │
│  5. Le groupe lit la critique et construit le prompt v2     │
│  6. EXÉCUTE v2 → compare le delta                          │
│                                                             │
│  Score = delta qualité entre résultat v1 et résultat v2     │
└─────────────────────────────────────────────────────────────┘
```

**Pourquoi la critique arrive AVANT le résultat ?**

En voyant les lacunes de leur prompt *avant* de voir le résultat, les participants anticipent plutôt que de constater après coup. Cela force une réflexion active sur la qualité du prompt, pas une réaction à un résultat décevant.

---

## 4. Guide défi par défi

---

### 🔍 Défi 1 — La PR Fantôme (10 min)

#### Ce que les groupes voient

> **INCIDENT #2847** — Une PR sur `SensorService.java` a été mergée hier après validation CI. Ce matin, l'équipe remonte des anomalies en production. La CI n'a rien vu. Votre mission : faire la revue de code que l'IA aurait dû faire avant le merge.

#### Ce que l'animateur sait (imperfections injectées)

| Problème | Localisation | Type |
|----------|-------------|------|
| Méthode `processReading()` ~50 lignes (validation + calcul + persistance) | `processReading()` | Violation SRP |
| `if (tmp > 847.5)` | ligne ~22 | Magic number |
| `threshold = 23.4` | ligne ~19 | Magic number |
| `int MAX = 1000` | déclaration | Magic number |
| Variables `tmp`, `flag`, `x` | corps de méthode | Nommage illisible |
| `return null` × 3 | fin de méthode | Gestion d'erreur — risque NPE |
| Pas d'interface implémentée | déclaration classe | Couplage / testabilité |

#### Ce qu'un bon prompt v2 doit permettre de trouver

- Violation SRP de `processReading()` avec suggestion de découper en `validateReading()`, `computeConvertedValue()`, `persist()`
- Les 3 magic numbers avec suggestion de constantes nommées
- Le `return null` avec suggestion d'`Optional<>` ou exception métier
- L'absence d'interface avec impact sur la testabilité
- Format : liste priorisée CRITIQUE/MAJEUR/MINEUR, chaque item avec ligne + suggestion actionnable

#### Hints (à débloquer sur demande ou si groupe bloqué)

| Hint | Moment | Contenu |
|------|--------|---------|
| Hint 1 | Après 4 min | "Pensez à préciser quel type de problèmes vous cherchez — SOLID, nommage, gestion d'erreurs..." |
| Hint 2 | Après 6 min | "Essayez de demander au LLM : combien de responsabilités distinctes compte la méthode principale ?" |
| Hint 3 | Après 8 min | "Demandez explicitement : 'Y a-t-il des valeurs numériques en dur ? Sont-elles nommées ?'" |

---

### 🧪 Défi 2 — Le Filet Manquant (10 min)

#### Ce que les groupes voient

> **INCIDENT #2901** — Le dossier `src/test/` est vide. Zéro test. Couverture : 0%. Un auditeur qualité passe demain. Votre mission : demander à l'IA de générer des tests unitaires pertinents pour `SensorService.java` — pas des tests qui compilent juste, des tests qui valident le comportement métier.

#### Ce que l'animateur sait

- `src/test/` est vide intentionnellement
- Les tests générés avec un prompt v1 vague seront en général : compilation OK, assertions triviales, pas de cas limites
- Les vrais cas limites à tester : valeur exactement à `847.5` (boundary), valeur nulle, comportement quand la persistance échoue

#### Ce qu'un bon prompt v2 doit permettre de trouver

- Tests avec JUnit 5 + Mockito (stack standard du projet)
- Au moins un test par : valeur normale, valeur limite `847.5`, valeur invalide (null, négative), erreur de persistance
- Nommage en style `should_[comportement]_when_[condition]`
- Mock du repository — pas d'accès base de données réel
- Structure Arrange / Act / Assert commentée

#### Hints

| Hint | Moment | Contenu |
|------|--------|---------|
| Hint 1 | Après 4 min | "Précisez le framework de test attendu : JUnit 5 + Mockito, Java 17, Spring Boot 3.2" |
| Hint 2 | Après 6 min | "Demandez explicitement les cas limites : valeur exactement au seuil 847.5, valeur null, exception lors de la persistance" |
| Hint 3 | Après 8 min | "Précisez que les tests doivent suivre Arrange / Act / Assert et mocker SensorRepository avec @Mock et @InjectMocks" |

---

### 📖 Défi 3 — Le Dev Perdu (10 min)

#### Ce que les groupes voient

> **INCIDENT #3012** — Un nouveau développeur rejoint l'équipe lundi. Il doit être opérationnel sur `leafguard-api` en 2 heures. Le README est vide. Votre mission : demander à l'IA de générer un README utile ET un diagramme Mermaid — pas une liste de getters.

#### Ce que l'animateur sait

- Le README du projet est vide ou minimal
- Un prompt v1 vague donnera : "Cette API surveille des capteurs." — trivial, sans exemples ni diagramme
- La vraie valeur : documenter le domaine métier, les endpoints avec exemples JSON, le flux architectural en Mermaid

#### Ce qu'un bon prompt v2 doit permettre de trouver

- README avec : description métier, prérequis, commande de démarrage exacte (`mvn spring-boot:run`), liste des endpoints (méthode + URL)
- Au moins 2 exemples `curl` avec corps de réponse JSON exact (ex: `{"sensorId":"SNS-001","value":23.4,...}`)
- Un diagramme Mermaid (`classDiagram` ou `sequenceDiagram`) intégré en bloc ` ```mermaid ``` ` illustrant le flux Controller → Service → Repository
- Le README permet de démarrer et faire un premier appel API en moins de 10 minutes

#### Hints

| Hint | Moment | Contenu |
|------|--------|---------|
| Hint 1 | Après 4 min | "Précisez le public cible : développeur Java confirmé qui ne connaît pas Spring Boot ni le projet" |
| Hint 2 | Après 6 min | "Demandez des exemples curl avec les réponses JSON exactes attendues, pas juste les URLs" |
| Hint 3 | Après 8 min | "Demandez explicitement un diagramme Mermaid (classDiagram ou sequenceDiagram) intégré dans le README" |

---

### 🔥 Défi 4 — L'Incendie Silencieux (10 min)

#### Ce que les groupes voient

> **INCIDENT #3156** — L'application est tombée à 3h12. L'astreinte a été réveillée. Le fichier `logs/app.log` contient les traces. Votre mission : demander à l'IA d'analyser les logs pour identifier la cause racine ET proposer comment améliorer le logging pour que ça n'arrive plus.

#### Ce que l'animateur sait

**Problèmes dans les logs :**
- `e.printStackTrace()` partout → logs illisibles en production
- Messages : `"Error occurred"`, `"Failed"` → aucune information utile
- `NullPointerException` sans contexte métier → impossible de savoir quel champ était null
- Pas de corrélation ID → impossible de tracer une requête de bout en bout

**Ce qui s'est réellement passé :** NPE dans `processReading()` sur la variable `tmp` après une validation partielle — mais les logs ne le disent pas.

#### Ce qu'un bon prompt v2 doit permettre de trouver

- Séquence causale chronologique : NPE sur `tmp`/`flag` dans `processReading()` → cascade → crash à 3h18
- Anti-patterns listés : `e.printStackTrace()`, messages sans contexte, absence de corrélation ID
- Exemples avant/après : `log.error("Error occurred")` → `log.error("Sensor reading failed for sensorId={}, value={}", sensorId, value, e)`
- Recommandation MDC pour corrélation ID de requête

#### Hints

| Hint | Moment | Contenu |
|------|--------|---------|
| Hint 1 | Après 4 min | "Donnez le contexte à l'IA : Java Spring Boot, SLF4J, application tombée à 3h12 et redémarrée à 3h18" |
| Hint 2 | Après 6 min | "Demandez deux choses séparément : (1) reconstitution chronologique des événements, (2) anti-patterns de logging" |
| Hint 3 | Après 8 min | "Demandez des exemples avant/après concrets pour au moins 2 messages d'erreur présents dans le fichier" |

---

## 5. Grille de scoring détaillée

### Tableau de scoring par défi

Chaque défi est noté sur **5 points maximum** — **calculé automatiquement par le LLM** après le `suite` v2 de chaque groupe.

| Critère | 0 pt | 1 pt | 2 pts | 3 pts |
|---------|------|------|-------|-------|
| **Delta qualité v1→v2** | Aucune amélioration | Légère (1-2 éléments génériques supplémentaires) | Amélioration claire (problèmes précis avec contexte) | Transformation majeure (couverture quasi complète) |
| **Lacunes corrigées** | Aucune lacune de la critique adressée dans v2 | 1 lacune corrigée | 2 lacunes ou plus corrigées | — |

> Le score apparaît automatiquement dans la conversation après chaque défi. En fin de session, les groupes tapent **`scores finaux`** pour obtenir le récapitulatif des 4 défis — à vous envoyer par capture d'écran ou copier-coller.

### Pourquoi deux critères — à expliquer aux groupes si la question est posée

Le **Delta v1→v2** mesure la qualité du livrable final. Les **Lacunes corrigées** mesurent autre chose : le groupe a-t-il réellement utilisé la critique pour construire son v2, ou a-t-il simplement retenté sa chance ?

**Ce que le score révèle en débrief :**

| Delta | Lacunes corrigées | Ce que ça dit du groupe |
|-------|-------------------|------------------------|
| 3/3 | 0/2 | Bon résultat mais ils n'ont pas utilisé la critique — expertise propre, pas dialogue LLM |
| 0/3 | 2/2 | Ils ont corrigé ce que la critique pointait mais le résultat v2 n'a pas encore décollé |
| 3/3 | 2/2 | Ils maîtrisent la boucle critique → correction → résultat — objectif atteint |

> Utilisez ce tableau pour orienter le débrief inter-groupes.

### Score total

| Plafond | Signification |
|---------|--------------|
| 20 pts (4 × 5) | Score parfait théorique |
| 14-20 pts | Groupe expert en prompting |
| 7-13 pts | Groupe intermédiaire — a compris le flow |
| 0-6 pts | Groupe débutant — mécanique v1→v2 pas encore assimilée |

### Lire rapidement les niveaux pendant le workshop

**Avant chaque inter-défi (2 min) :**
1. Demander à 1-2 groupes de lire leur prompt v2 à voix haute
2. Grouper par niveau (fort / moyen / à aider) — le score LLM confirme votre lecture visuelle

**Indicateurs rapides :**
- Le prompt v2 contient le nom du fichier, la stack et un format de sortie demandé ? → Delta ≥ 2 probable
- Le groupe a exploité la critique LLM pour réécrire ? → Qualité critique ≥ 1 probable

---

## 6. Commandes LLM disponibles

> À connaître par cœur. Ces triggers sont définis dans la directive embarquée de `workshop-2905.md`.

| Commande | Effet |
|----------|-------|
| `lance le workshop` | Affiche le briefing (contexte + mécanique + scoring) |
| `go` | Lance le Défi 1 |
| `défi 2` | Lance le Défi 2 |
| `défi 3` | Lance le Défi 3 |
| `défi 4` | Lance le Défi 4 |
| `suite` | Affiche le résultat du dernier prompt envoyé |
| `solution défi 1` (ou 2, 3, 4) | Révèle le prompt v2 de référence + éléments attendus |
| `scores finaux` | Récapitulatif des scores des 4 défis depuis la conversation — à envoyer à l'animateur |
| *(tout autre texte)* | Déclenche la critique du prompt — STOP avant le résultat |

> **À communiquer aux groupes** : la commande `solution défi N` est disponible à tout moment, mais à utiliser **après** avoir tenté leur propre v2.
> **Collecte des scores** : demander à chaque groupe de taper `scores finaux` et de vous envoyer le résultat (capture d'écran ou message). Pas de saisie manuelle requise.

---

## 7. Conseils d'animation

### 🚀 Comment lancer chaque défi

**Structure de l'annonce narrative (30 secondes max) :**

1. **L'incident** (ton dramatique) : "À 3h12 du matin, l'astreinte est réveillée..."
2. **La mission** (clair et direct) : "Votre mission : trouver la cause dans les logs."
3. **La règle** (rappel systématique) : "Prompts uniquement. Pas de code."
4. **Le timer** : "Vous avez 10 minutes. Top départ."

> Lancer le timer immédiatement après "Top départ".

### 🆘 Comment gérer un groupe bloqué

| Situation | Question à poser au groupe |
|-----------|---------------------------|
| Bloqués sur formulation | "Si vous deviez expliquer le problème à un collègue senior en 3 phrases, que diriez-vous ?" |
| Résultat trop générique | "Est-ce que le LLM savait qu'il travaillait sur une API de capteurs Spring Boot ?" |
| N'ont pas fait le méta | "Avez-vous demandé au LLM ce qui manquait dans votre premier prompt ?" |
| Bon résultat, paniqués par le temps | "Vous avez déjà un bon v2 — notez-le et passez au scoring" |

> Ne jamais donner la réponse directement. Toujours poser une question qui les fait raisonner eux-mêmes.

### 🏆 Comment animer la comparaison inter-groupes (2 min)

1. Demander à **un groupe volontaire** de lire son prompt v1 → pause → lire son prompt v2
2. Demander à la salle : "Qu'est-ce qui a changé entre les deux ?"
3. Nommer explicitement les patterns : "Ils ont ajouté le contexte métier. Ils ont précisé le format de sortie."

### 💬 Débrief collectif — questions par défi

**Défi 1 :**
- "Combien de problèmes votre v1 avait-il trouvés ? Votre v2 ?"
- "Un outil de lint aurait trouvé les mêmes choses ?"

**Défi 2 :**
- "Les tests générés par v1 auraient-ils vraiment protégé contre un bug en production ?"
- "Comment avez-vous guidé le LLM vers les cas limites ?"

**Défi 3 :**
- "Votre diagramme Mermaid est-il réellement juste architecturalement ?"
- "La documentation permettrait-elle vraiment à quelqu'un de démarrer en 10 min ?"

**Défi 4 :**
- "Le LLM a-t-il trouvé la cause racine avec votre v1 ?"
- "Pourquoi `e.printStackTrace()` est un problème en production et pas en dev ?"

### 🎯 Question d'amorce finale

> **"Qu'est-ce qui a changé entre votre prompt v1 et votre prompt v2 ?"**

Synthétiser autour des 4 dimensions de la cheat sheet :

| Dimension | v1 (typique) | v2 (amélioré) |
|-----------|-------------|--------------|
| **Contexte** | Absent | Stack, domaine métier, criticité |
| **Objectif** | Vague ("fais une revue") | Précis ("trouve les violations SOLID, les magic numbers, les null returns") |
| **Format** | Absent | Spécifié (liste priorisée, diagramme Mermaid, etc.) |
| **Audience** | Non précisée | Définie (développeur senior, développeur junior, auditeur...) |

**Message de clôture suggéré :**
> "Un LLM n'est pas magique. Il répond à ce que vous lui donnez. Contexte + objectif + format = résultat utilisable. C'est ça, le prompting."

---

## 8. FAQ technique

### ❓ Si IntelliJ / Copilot ne fonctionne pas sur une machine

1. Copilot connecté ? `File > Settings > GitHub Copilot` — vérifier le statut
2. Plugin activé ? `File > Settings > Plugins` — vérifier qu'il est actif et à jour
3. Licence valide ? Le compte GitHub doit être rattaché à la licence d'équipe RTE

**Solution de repli :**
- Copilot Chat dans le navigateur (copilot.github.com) — fonctionnalité identique
- En dernier recours : un groupe rejoint un groupe voisin (mob élargi)

### ❓ Si le build Maven échoue

```bash
mvn --version           # Java 17 requis, Maven 3.8+
java --version          # Doit afficher openjdk 17 ou +
mvn dependency:resolve  # Vérifier que les dépendances se téléchargent
```

Si pas de réseau : `mvn compile -o` (mode offline — fonctionne si le repo local est peuplé).

Les imperfections volontaires n'empêchent pas la compilation — ce sont des problèmes de qualité, pas de syntaxe.

### ❓ Si la directive LLM ne s'applique plus (défi 2+)

Signe : le LLM répond directement sans critique.

Demander au groupe de taper dans l'outil LLM :
```
Rappel : pour tout prompt de travail dans ce workshop, tu dois produire UNIQUEMENT une critique (max 4 points) et t'arrêter. Ne produis pas le résultat avant que je tape "suite".
```

### ❓ Si un groupe finit trop vite

**Option bonus officielle :**
> "Demandez à votre LLM : 'solution défi N' pour voir le prompt v2 de référence. Comparez avec le vôtre — qu'avez-vous de différent ?"

Ou : "Demandez au LLM de critiquer votre prompt v2 — construisez un v3."

---

*🌿 Opération LeafGuard — Feuille Animateur · Workshop 29/05 · Version 2.0*  
*NDA RTE — usage interne Zenika uniquement*
