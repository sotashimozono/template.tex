# LuaLaTeX + BibTeX (revtex4-2 uses bibtex, not biber)
$lualatex   = 'lualatex -shell-escape -interaction=nonstopmode -synctex=1 -file-line-error %O %S';
$pdf_mode   = 4;    # 1=pdflatex, 4=lualatex, 5=xelatex
$bibtex_use = 1;    # 1=bibtex

# Output directory (relative to root .tex file)
$out_dir = 'out';

# Clean targets (in addition to latexmk defaults)
$clean_ext = 'bcf run.xml synctex.gz synctex(busy) idx ind ilg acn acr alg glg glo gls ist nav snm vrb xdv';
