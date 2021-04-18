#!/bin/bash

#### #SBATCH --account=PAS1855
#### #SBATCH --output=slurm-tree-blast-%j.out

#### set -e -u -o pipefail

echo "activating mycotools-user conda environment"
source activate mycotools-user

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
  db2blast.py -q "$blasting" -b blastn -e 2 --cpu 10 -o "$outputs" 
  echo "Blast completed"

  # get path to where fastas were output to
  yyyymmdd=$(date "+%Y%m%d")
  fastas_directory="${outputs}/${yyyymmdd}_db2blast/fastas"
  reports_directory="${outputs}/${yyyymmdd}_db2blast/reports"

  # report number of fastas retrieved
  fasta_count=$(ls "$fastas_directory" | wc -l)
  fileName=$(basename "$blasting")

  # delete reports that are 0 bytes?
  find "$reports_directory" -size  0 -delete

  echo "Blast output in $fastas_directory"
  echo "Retrieved $fasta_count fastas for the input file $fileName"

  if [ "$(ls -A $fastas_directory)" ]; then
    # create tree from the retrieved fastas and output it to the output folder
    echo "Building tree"
    wkdir=$(pwd)
    outputTrees="${wkdir}/outputTrees/${blastingFileNameOnly}"
    mkdir -p "$outputTrees"
    fa2tree.py -i "${wkdir}/${fastas_directory}" -t fasttree -o "$outputTrees"
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