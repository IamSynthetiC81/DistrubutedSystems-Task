#!/bin/bash

# Όνομα του αρχείου (χωρίς το .tex)
FILENAME="report"

# Έλεγχος αν υπάρχει το xelatex
if ! command -v xelatex &> /dev/null
then
    echo "Σφάλμα: Το xelatex δεν είναι εγκατεστημένο."
    exit 1
fi

echo "Ξεκινάει το compilation του $FILENAME.tex με XeLaTeX..."

# Πρώτο πέρασμα
xelatex $FILENAME.tex

# Δεύτερο πέρασμα
xelatex $FILENAME.tex

# Καθαρισμός προσωρινών αρχείων
rm -f $FILENAME.aux $FILENAME.log $FILENAME.out $FILENAME.toc

echo "-----------------------------------"
echo "Επιτυχία! Το αρχείο $FILENAME.pdf δημιουργήθηκε και τα Αγγλικά είναι πλέον Αγγλικά."