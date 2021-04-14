#!/bin/bash

blasting="$1"

# blasts against master database by default
# blastn to run blastn (nucleotides)
# recommended -e is 2
# outputs blasted files to pullFiles
echo "Blasting"
db2blast.py -q "$blasting" -b blastn -e 2 --cpu 1 -o pullFiles 
echo "Blast completed"

# get path to where fastas were output to
fastas_directory="pullFiles/fastas"

# report number of fastas retrieved
fasta_count=$(ls "$fastas_directory" | wc -l)
fileName=$(basename "$blasting")
echo "Retrieved $fasta_count fastas for the input file $fileName"

# TODO other reporting here
