# Figé via Debian trixie (= TeX Live 2025). Jamais "latest".
FROM debian:trixie-slim

# Collections TeX Live couvrant les \usepackage de ifri.cls, + latexmk et makeglossaries.
# (À tenir à jour si on ajoute un package : voir config dans ifri.cls.)
#   base/recommended : fontenc, inputenc, babel, geometry, graphicx, amsmath,
#                      amsfonts, xcolor, url, hyperref, setspace, caption,
#                      multirow, longtable, tocbibind, listings
#   extra            : fncychap, titlesec, titletoc, fancyhdr, lastpage,
#                      changepage, framed, tocloft, minitoc, pdfpages,
#                      pdflscape, glossaries, listingsutf8
#   fonts-recommended: mathpazo, courier, pifont
#   science          : algorithm2e
#   lang-french      : babel french, minitoc francais
#   extra-utils      : makeglossaries
#   publishers       : IEEEtran (style bibliographique IEEE)
RUN apt-get update && apt-get install -y --no-install-recommends \
        texlive-latex-base \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-science \
        texlive-lang-french \
        texlive-extra-utils \
        texlive-publishers \
        latexmk \
    && rm -rf /var/lib/apt/lists/*

# HOME writable quel que soit l'UID passé au run (caches TeX Live).
ENV HOME=/tmp

WORKDIR /work

# Les sources restent sur l'hôte (volume monté) ; le PDF est produit à la racine.
# Commandes build/run selon le terminal (bash, PowerShell, cmd) : voir le README.
CMD ["latexmk", "main.tex"]
