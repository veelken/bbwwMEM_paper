#!/bin/bash

if [[ "$1" = "clean" ]]; then
  rm -fv bbwwMEM.bbl bbwwMEM.blg bbwwMEM.aux bbwwMEM.out bbwwMEM.log bbwwMEM.spl bbwwMEM.pdf bbwwMEM_grayscale.pdf
  exit 0
fi

# run:
# NONSTOP=1 ./make.sh
# in order to disable interactive prompts
if [ "$NONSTOP" = 1 ]; then
  PDFLATEX_ARGS="-interaction=nonstopmode"
fi

# CV: without this clean-up, 
#     latex produces an error when switching between paper and arXiv version
rm bbwwMEM.aux

pdflatex $PDFLATEX_ARGS bbwwMEM.tex
bibtex bbwwMEM
pdflatex $PDFLATEX_ARGS bbwwMEM.tex
pdflatex $PDFLATEX_ARGS bbwwMEM.tex

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

cp bbwwMEM.pdf ~

#acroread bbwwMEM.pdf

