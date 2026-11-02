# Configuration de compilation commune (local, Docker, Overleaf).
# Source de vérité unique de la chaîne : à ne pas dupliquer ailleurs.

# Moteur : pdfLaTeX
$pdf_mode = 1;

# Bibliographie : biblatex + biber
$bibtex_use = 2;

# Fichiers auxiliaires dans build/
# PDF final à la racine
$aux_dir = 'build';
$out_dir = '.';
$emulate_aux = 1;

# Les \include en sous-dossiers (liminaires/, chapitres/) écrivent leur .aux dans build/.
# On pré-crée l'arborescence du projet dans build/ pour éviter l'erreur « I can't write on file .../xxx.aux » la première fois.
use File::Path qw(make_path);
for my $d (glob('*/ */*/')) {
    $d =~ s{/$}{};
    next if $d =~ m{^(build|\.git)(/|$)};
    make_path("$aux_dir/$d");
}

# Glossaire et acronymes, makeglossaries (acn à acr, glo à gls)
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
sub run_makeglossaries {
    my ($base, $path) = fileparse($_[0]);
    pushd $path;
    system( $silent ? "makeglossaries -q '$base'" : "makeglossaries '$base'" );
    popd;
}

# Extensions supplémentaires à nettoyer avec `latexmk -c` (glossaire, minitoc)
$clean_ext = 'acn acr alg glo gls glg ist loa mtc mtc0 ptc maf run.xml';
