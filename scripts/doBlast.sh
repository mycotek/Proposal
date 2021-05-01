#!/bin/bash

#SBATCH --account=PAS1855
#SBATCH --output=slurm-tree-blast-%j.out


echo "activating mycotools-user conda environment"
source activate mycotools-user

# there is a bug where doing set -u causes conda to break when doing source activate:
# https://github.com/conda/conda/issues/8186
set -e -u -o pipefail

# blast input needs to be a .fasta or .fna
blasting="$1"
blastingFileName=$(basename "$blasting")
blastingFileNameOnly="${blastingFileName%.*}"
blastingFileExtension="${blastingFileName##*.}"

# blasting file must be fasta or fna
# echo "Extension is $blastingFileExtension"
if [ "$blastingFileExtension" = "fasta" ] || [ "$blastingFileExtension" = "fna" ]; then 

  # blasts against master database by default
  # blastn to run blastn (nucleotides)
  # recommended -e is 2
  # outputs blasted files to pullFiles
  # -m is max hits, limiting to 25 for now
  echo "Blasting $blasting"
  outputs="pullFiles/${blastingFileNameOnly}"
  mkdir -p "$outputs"
  db2blast.py --query "$blasting" -b blastn -e 2 -m 25 --cpu 10 -o "$outputs" 
  echo "Blast completed"

  # get path to where fastas were output to
  yyyymmdd=$(date "+%Y%m%d")
  fastas_directory="${outputs}/${yyyymmdd}_db2blast/fastas"
  reports_directory="${outputs}/${yyyymmdd}_db2blast/reports"

  # report number of fastas retrieved
  fasta_count=$(ls "$fastas_directory" | wc -l)
  fileName=$(basename "$blasting")

  echo "Blast output in $fastas_directory"
  echo "Retrieved $fasta_count fastas for the input file $fileName"

  if [ "$(ls -A $fastas_directory)" ]; then
    # create tree from the retrieved fastas and output it to the output folder
    echo "Building tree"
    wkdir=$(pwd)
    outputTrees="${wkdir}/outputTrees/${blastingFileNameOnly}"
    mkdir -p "$outputTrees"
    fa2tree.py -i "${wkdir}/${fastas_directory}" -t fasttree  -s -A PAS1855 -o "$outputTrees" 
    echo "Tree completed."

    # find the tree file 
    mostRecentTreeDir=$(ls "$outputTrees" -t | head -n1)
    # echo "Most recently created tree directory is ${mostRecentTreeDir}"
    pathToTreeDir="${outputTrees}/${mostRecentTreeDir}"
    # find the file with the .tre extension to print as feedback
    # echo "Directory to look inside is ${pathToTreeDir}"
    theTreFile=$(find "$pathToTreeDir" -name "*.tre" | head -n1)
    echo "Tree file is ${theTreFile}"
  else
    echo "Blast returned no results for input fasta $blasting"
  fi

else
  echo "Must input a .fasta or .fna file to BLAST"
fi