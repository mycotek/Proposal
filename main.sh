#!/bin/bash

the_input="$1"
fasta_name=$(basename "$the_input")

echo "Starting workflow to create a tree showing relationships to $fasta_name"

# run setup
./setup.sh

# do blast 
./doBlast.sh $the_input   # passing input fasta to blast

# make tree
./doTree.sh

echo "Complete"