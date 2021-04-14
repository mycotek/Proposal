git# Overview

The scripts to be written for the process are:

1. One to setup the folder structure (setup.sh)
2. One that, given a gene, will BLAST it to find related genes. This will also list information about what was retrieved from the BLAST
4. One that produces a phylogenetic tree using the original gene and displays it
5. A script that runs all the other scripts

The first script will be the place for any setup needed to simplify the other scripts. The second script will take only a single .fasta file as its input, and then utilize the db2blast.py tool. This script will also write some information about what was retrieved to a log file such as when the blast was ran and how many .fasta files it retrieved. The third script will run the fa2tree.py tool to create a tree, and if possible display it. The final script will simply run the first 4 scripts in sequence. 

