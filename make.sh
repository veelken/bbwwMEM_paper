#!/bin/bash

if [[ "$1" = "clean" ]]; then
  rm -fv bbwwMEM.bbl bbwwMEM.blg bbwwMEM.aux bbwwMEM.out bbwwMEM.log bbwwMEM.pdf bbwwMEM_grayscale.pdf
  exit 0
fi

pdflatex bbwwMEM.tex
bibtex bbwwMEM
pdflatex bbwwMEM.tex
pdflatex bbwwMEM.tex

# convert to grayscale
if [[ -f bbwwMEM.pdf ]] && [[ "$1" = "grayscale" ]]; then
  gs \
   -sOutputFile=bbwwMEM_grayscale.pdf \
   -sDEVICE=pdfwrite \
   -sColorConversionStrategy=Gray \
   -dProcessColorModel=/DeviceGray \
   -dCompatibilityLevel=1.4 \
   -dNOPAUSE \
   -dBATCH \
   bbwwMEM.pdf
fi

#acroread bbwwMEM.pdf

