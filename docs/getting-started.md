# 🚀 Getting Started - Opération LeafGuard

> Guide pas-à-pas pour les participants · À lire **avant** le démarrage du workshop

---

## Prework — À faire AVANT le jour J (5-10 min)

> ⚠️ Le setup doit être terminé **avant** le début du workshop. Ne pas attendre le signal de l'animateur pour cette étape.

Ouvrez un terminal et exécutez ces deux commandes :

```bash
java -version
mvn -version
```

**Résultat attendu :**
- `java -version` → doit afficher `17` ou supérieur
- `mvn -version` → doit afficher `3.6` ou supérieur

> ❌ Si l'une des deux commandes échoue, signalez-le à l'animateur **avant** le démarrage.

Vérifiez aussi que **GitHub Copilot** est actif dans IntelliJ (icône Copilot visible dans la barre de statut) ou que **Junie** est disponible.

### Récupérer le projet leafguard-api

Ouvrez un terminal et exécutez :

```bash
git clone https://github.com/MrZzE00/operation-leafguard
cd operation-leafguard
chmod +x inject-defects.sh && ./inject-defects.sh
```

Le script prépare le projet pour le workshop. Vous verrez : `✅ leafguard-api prêt pour le workshop`.

Puis compilez pour vérifier :

```bash
cd leafguard-api && mvn compile -q && echo "✅ BUILD OK"
```

**Durée estimée : 2 à 5 minutes** selon la vitesse de téléchargement des dépendances Maven (première fois uniquement).

> ⚠️ Si Maven télécharge des dépendances pour la première fois, c'est normal — laissez-le finir.

### Importer dans IntelliJ

1. `File → Open` → sélectionnez le dossier `leafguard-api` (à l'intérieur de `operation-leafguard`)
2. Cliquez **Trust Project** si demandé
3. Attendez la fin de l'indexation (barre de progression en bas)
4. Vérifiez que le build passe : `Build → Build Project` ou `Ctrl+F9`

> ✅ Si les fichiers Java apparaissent dans l'arborescence et que le build passe, le prework est terminé.

---

## Étape 1 - Choisissez votre rôle dans le groupe

Le workshop fonctionne en **Mob Programming** : un seul clavier, tout le monde contribue.

| Rôle | Responsabilité |
|------|----------------|
| 🖥️ **Pilote** | Tient le clavier. Exécute ce que le groupe décide. Ne prend pas d'initiative seul. |
| 🧠 **Navigateurs** (les autres) | Réfléchissent au prompt, verbalisent leurs idées, challengent le pilote. |

> **Règle d'or** : le pilote ne tape rien sans que le groupe l'ait verbalisé à voix haute d'abord.

Rotation libre : vous pouvez changer de pilote entre les défis, ou quand vous le souhaitez.

---

## Étape 2 - Ouvrez le fichier workshop dans IntelliJ

1. Ouvrez **IntelliJ IDEA**
2. Allez dans `File → Open` et sélectionnez le fichier `workshop-2905.md`
3. Activez la **prévisualisation Markdown** (icône en haut à droite de l'éditeur) pour une lecture confortable

> Vous pouvez aussi simplement lire le fichier dans un éditeur de texte si IntelliJ pose problème.

---

## Étape 3 - Comprenez la règle fondamentale

> **Vous ne tapez pas de code. Vous tapez uniquement des prompts.**
> C'est l'IA qui travaille — vous, vous dirigez.

Ce workshop mesure la **qualité de vos prompts**, pas vos connaissances Java.

---

## Étape 4 - Comprenez le flow de chaque défi

Chaque défi se déroule en **5 étapes obligatoires** :

```
┌──────────────────────────────────────────────────────────────────┐
│                      FLOW PAR DÉFI (10 min)                      │
│                                                                  │
│  1. LISEZ le contexte de l'incident (2 min)                      │
│  2. RÉDIGEZ un prompt v1 — votre intuition naturelle             │
│  3. ENVOYEZ le prompt dans Copilot Chat ou Junie                 │
│  4. Le LLM critique votre prompt AVANT de produire le résultat  │
│     → ce qui est vague, ce qu'il va devoir supposer             │
│  5. LISEZ la critique collectivement                             │
│  6. RÉDIGEZ le prompt v2 en corrigeant les lacunes,              │
│     exécutez, observez le delta                                  │
│  7. À la fin du défi, tapez "défi 2" / "défi 3" / "défi 4"      │
│     pour passer à l'incident suivant                             │
│                                                                  │
│  Score = delta qualité entre v1 et v2                            │
└──────────────────────────────────────────────────────────────────┘
```

> Le LLM critique votre prompt **avant** de produire le résultat — vous n'avez rien à demander. C'est la directive embarquée dans `workshop-2905.md` qui déclenche ce comportement automatiquement.

---

## Étape 5 - Le scoring

Le LLM calcule automatiquement le score à la fin de chaque défi (après votre `suite` v2) :

| Critère | Max |
|---------|-----|
| **Delta v1→v2** | 3 pts |
| **Lacunes corrigées** | 2 pts |

**Max par défi : 5 pts · Max total : 20 pts**

**Pourquoi deux critères distincts ?**
Le Delta mesure la qualité du livrable final. Les Lacunes corrigées mesurent autre chose : avez-vous réellement exploité la critique pour améliorer votre prompt v2 ? En production, savoir itérer sur un feedback est une compétence distincte de savoir produire un bon résultat du premier coup. Un groupe qui améliore son v2 sans lire la critique et un groupe qui corrige précisément chaque lacune pointée n'ont pas le même niveau — ce critère les distingue.

En fin de session, tapez **`scores finaux`** dans votre outil LLM pour obtenir le récapitulatif complet des 4 défis. Envoyez-le à l'animateur (capture d'écran ou copier-coller).

---

## En cas de blocage

**Vous ne savez pas comment commencer un prompt ?**
→ Consultez les **Hints** de chaque défi (balises `<details>` dans le fichier workshop). Ouvrez-les dans l'ordre, un par un.

**Vous ne savez pas comment passer au défi suivant ?**
→ Tapez exactement : **défi 2**, **défi 3** ou **défi 4** dans votre outil LLM.

**Vous voulez comparer votre v2 avec la solution attendue ?**
→ Tapez : **solution défi 1** (ou 2, 3, 4) dans votre outil LLM.
→ À utiliser **après** avoir tenté votre propre v2 — pas avant.

**Vous voulez voir votre score total en fin de session ?**
→ Tapez : **scores finaux** dans votre outil LLM. Le récapitulatif des 4 défis s'affiche automatiquement.

**Le LLM ne donne pas un résultat satisfaisant ?**
→ C'est normal au prompt v1 — c'est précisément pour ça qu'il y a un v2. Utilisez la critique LLM.

**IntelliJ ou Copilot ne répond pas ?**
→ Utilisez Copilot Chat dans le navigateur, ou Junie directement. Signalez le problème à l'animateur.

**Le script inject-defects.sh échoue ?**
→ Vérifiez que vous êtes bien dans le dossier `operation-leafguard` (celui créé par le `git clone`) avant de lancer le script.

**mvn compile échoue avec une erreur ?**
→ Vérifiez que `java -version` retourne bien 17+. Si le problème persiste, appelez l'animateur.

---

## Récapitulatif — Ordre des actions

```
✅ [PREWORK] Vérifier java + mvn en terminal
✅ [PREWORK] git clone + inject-defects.sh + mvn compile
✅ [PREWORK] Importer leafguard-api dans IntelliJ + vérifier le build
✅ [WORKSHOP] Choisir le pilote du groupe
✅ [WORKSHOP] Ouvrir workshop-2905.md dans Copilot Chat ou Junie
✅ [WORKSHOP] Attendre le signal de l'animateur pour taper "lance le workshop"
```

---

*🌿 Opération LeafGuard · RTE DDL · 29 mai 2025*
