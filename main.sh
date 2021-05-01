#!/bin/bash

# This is the main script that runs everything

the_input="$1"

# run setup
./scripts/setup.sh

#retrieve a file from ncbi by quering with an organism name
name="${the_input// /_}"
outputFastaName="${name}.fasta"
echo "Output name is $outputFastaName"
python3 scripts/getFasta.py "$the_input" "$outputFastaName"
outputFastaPath="pullFiles/${outputFastaName}"

# does the fasta exist? If not, print no search results and quit
# otherwise, blast it

if [ -e "$outputFastaPath" ]; then 
  # do blast 
  ./scripts/doBlast.sh "$outputFastaPath"   # passing input fasta to blast
  # sbatch doBlast.sh "$outputFastaPath"
  echo "Complete" 
else
  echo "No fasta retreived for $the_input"
fi