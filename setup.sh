#!/bin/bash

# using the cutadapt environment from week 6's assignment since its already setup
module load python/3.6-conda5.2
source activate cutadapt-env

# make sure the right libraries are installed (-y installs without prompt for yes/no)
# -q makes it so conda install is quiet (does not print)

# this takes a while so leaving it commented out for now
# echo "Ensuring libraries are installed"
# conda install -y -q mycotools
# conda install -y -q blast
# conda install -y -q iqtree 
# conda install -y -q fasttree 
# conda install -y -q mafft 
# conda install -y -q trimal
# echo "Done ensuring libraries are installed"

# set paths for usage of mycotools
export MYCODB=/fs/project/PAS1046/databases/konkel 	# database
export MYCOFNA=$MYCODB/assembly/ 	# database assemblies
export MYCOFAA=$MYCODB/proteome/ 	# database proteomes
export MYCOGFF3=$MYCODB/gff3/ 		# database gff3s

# 
# temporarily downloaded mycotools since conda install was not working for some reason
if [[ "$PYTHONPATH" == *"/fs/ess/PAS1855/users/nomiotek/project/download/mycotools"* ]]; then
    echo "Already have this added to PYTHONPATH"
else 
    export PYTHONPATH=$PYTHONPATH:/fs/ess/PAS1855/users/nomiotek/project/download/mycotools
fi 

mycodb_path=$(mycodb)  # put mycodb path into its own variable (command currently not working)
echo "Mycodb path is $mycodb_path"

mkdir -p pullFiles   # directory for downloaded files
mkdir -p outputTrees # directory for the created phylogenetic trees
