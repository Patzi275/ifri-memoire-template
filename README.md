# Template de mémoire IFRI

Template LaTeX *non officiel* pour les mémoires et projets de fin de formation de l'IFRI (UAC).
Pensé pour être simple à prendre en main, portable (Windows, Linux, WSL, Overleaf) et reproductible.

**Sommaire**

- [Compiler](#compiler)
- [Éditeurs de texte](#éditeurs-de-texte)
- [Remplissage du mémoire](#remplissage)
- [Structure](#structure)
- [Ressources utiles](#ressources-utiles)
- [Contribution](#contribution)
- [Licence](#licence)

## Compiler

La compilation passe toujours par **`latexmk`**, qui enchaîne automatiquement les passes
(pdfLaTeX, bibliographie, glossaire). Une seule commande suffit :

```bash
latexmk main.tex      # produit main.pdf à la racine
latexmk -pvc main.tex # recompile à chaque sauvegarde
latexmk -c            # nettoie les fichiers auxiliaires (dans build/)
```

Cette commande est **la même partout**. Les trois méthodes ci-dessous ne changent pas la
compilation : elles diffèrent seulement par **l'endroit où `latexmk` (et TeX Live) est installé**.
Choisissez-en une.

### 1. Localement (TeX Live ou MiKTeX)

Installez une distribution LaTeX, puis lancez `latexmk main.tex`.

- **TeX Live** (Linux, WSL, macOS) : installation complète, ou installez les packages manquants au besoin.
- **MiKTeX** (Windows) : installez aussi **Strawberry Perl**, dont `latexmk` a besoin.

### 2. Avec Docker (sans installer LaTeX)

Deux étapes distinctes :

- **`docker build`** *construit* l'image (installe TeX Live dedans) : **une seule fois**, et à refaire
  seulement si le `Dockerfile` change. L'image fait environ **1,4 Go**.
- **`docker run`** *exécute* `latexmk` dans cette image pour *générer le PDF* : **à chaque compilation**, et rapide.

La commande de lancement dépend du terminal :

```bash
# Linux / macOS / WSL
docker build -t ifri-latex .
docker run --rm -v "$PWD":/work -u "$(id -u):$(id -g)" ifri-latex
```

```powershell
# Windows PowerShell
docker build -t ifri-latex .
docker run --rm -v "${PWD}:/work" ifri-latex
```

```bat
:: Windows cmd
docker build -t ifri-latex .
docker run --rm -v "%cd%:/work" ifri-latex
```

### 3. Sur Overleaf

Importez le dossier (ou un zip), ouvrez `main.tex` et compilez. Overleaf gère tout en ligne.

> Pour obtenir un PDF **identique** partout, utilisez la même année TeX Live sur les trois
> méthodes (le Dockerfile est figé sur TeX Live 2025 ; réglez Overleaf en conséquence).

## Éditeurs de texte

Aucun éditeur n'est imposé : n'importe quel éditeur convient, du moment qu'il sait lancer
`latexmk`. Deux choix courants pour travailler en local (Overleaf a son propre éditeur, voir méthode 3) :

- **VS Code** + l'extension *LaTeX Workshop* : réglez la recette de compilation sur `latexmk` (elle lit le `.latexmkrc` du projet).
- **TeXstudio** ou **TeXmaker** : éditeurs LaTeX dédiés ; pointez la commande de compilation sur `latexmk`.

## Remplissage

1. **`configuration/metadonnees.tex`** : titre, auteur, option, jury, dates. Le seul fichier d'identité à remplir.
2. **`liminaires/`** et **`chapitres/`** : écrivez votre contenu. Les chapitres sont déjà pré-structurés (état de l'art, méthodologie, résultats) — titres et sections adaptables.
3. **`images/`** pour les figures, **`biblio.bib`** pour les références (`\cite{...}`), **`configuration/glossaire.tex`** pour les acronymes.

Vous n'avez pas forcément besoin de toucher à la mise en page : elle vit dans `ifri.cls`.

## Structure

```
main.tex            Point d'entrée (assemble le document)
ifri.cls            Classe : mise en page + page de garde (en principe, pas à modifier)
biblio.bib          Références bibliographiques
configuration/      metadonnees.tex (à remplir), glossaire.tex
liminaires/         dédicace, remerciements, résumé
chapitres/          introduction.tex, conclusion.tex,
                    chapitre-1/ 2/ 3/ (un dossier par chapitre, un fichier par section)
annexes/            annexe.tex (désactivée par défaut dans main.tex)
images/             logos et figures
.latexmkrc          Chaîne de compilation (ne pas dupliquer ailleurs)
Dockerfile          Image TeX Live figée (méthode Docker)
```

## Ressources utiles

**LaTeX** pour débuter ou approfondir :

- [Documentation LaTeX d'Overleaf](https://www.overleaf.com/learn) : le point de départ, très complet et en libre accès.
- [Apprendre LaTeX en 30 minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes) : l'essentiel pour commencer.
- [Gérer la bibliographie avec BibTeX](https://www.overleaf.com/learn/latex/Bibliography_management_with_bibtex) : pour `biblio.bib` et `\cite`.
- [Package `glossaries`](https://www.overleaf.com/learn/latex/Glossaries) : pour les acronymes et le glossaire.
- [latexmk](https://ctan.org/pkg/latexmk) : l'outil de compilation utilisé par ce template.

**Rédaction du mémoire** :

- [Guide de rédaction (Dr. John AOGA)](https://johnaoga.github.io/guide-redaction)
- [Réussir son mémoire en informatique (Dr. Ratheil HOUNDJI)](https://ratheil.info/teaching-resources/reussir-son-memoire-en-informatique.pdf)

## Contribution

Suggestions et corrections bienvenues (issue ou pull request). Quelques règles pour garder le template sain :

- `latexmk` / `.latexmkrc` est la seule source de vérité de la compilation : ne dupliquez pas les options ailleurs.
- Testez vos changements sur les trois méthodes (local, Docker, Overleaf) ; le rendu doit rester identique, sauf changement voulu et annoncé.
- Pas de dépendance à `--shell-escape` (incompatible Overleaf).
- Si vous ajoutez un package, mettez à jour la liste du `Dockerfile` en conséquence.

## Licence

[LPPL 1.3c](https://www.latex-project.org/lppl/lppl-1-3c/), comme le template IFRI d'origine.
`ifri.cls` (modifiée) crédite ses auteurs d'origine dans son en-tête.


