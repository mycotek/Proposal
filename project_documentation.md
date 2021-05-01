# Overview

This workflow takes an organism name, retrieves a fasta file from NCBI, blasts it, and then creates a tree from it. This project was for gaining familiarity with these tools.

# Scripts

1. setup.sh
   This bash script checks to see if there is a conda environment called "mycotools-user". 
   If this conda environment does not exist then its created using the "environment.yml"
   file that is inside the top level directory of the repository. "environment.yml" has
   the information for creating the conda environment, including all libraries required
   to run the tools. When the environment is created, all required libraries are installed.
   The setup.sh tool also creates the "pullFiles" and "outputTrees" directories.
   These directories store intermediate files during the rest of the workflow.

2. getFasta.py
   This python script takes an organism name and a fasta file name. The script then uses the
   organism name to do a search on the nucleotides database from NCBI using the library
   provided by NCBI called "Entrez". The search is limited to up to 20 results. After
   the search is done, the script will create a temporary directory, and then download each result into its own fasta file in that directory. The script then determines which file is the largest, and then selects that as the fasta file to keep. The script then copies this largest fasta file to keep outside of the temporary directory, and into the "pullFiles" directory that should have been created by setup.sh. The script then deletes the temporary directory.

3. doBlast.sh
   This bash file takes a chosen fasta file, and then BLASTs it against the NCBI nucleotides database. The script then creates a tree from this. This script uses mycotools scripts, so the first thing it does is ensure that the mycotools-user conda environment is activated. The script then verifies that the file extension of its input is "fasta" or "fna". The script then creates an output directory in "pullFiles" based on the name of the fasta file to blast, then uses the mycotools process "db2blast.py" to BLAST the fasta file against the NCBI nucleotides database, using 2 for the "Negative e-value order max" parameter. After these fasta files are downloaded from db2blast.py, the script verifies that the BLAST returned results (i.e. the output directory is not empty). If there are BLAST results, then the script will use the mycotools process "fa2tree.py" to create a phylogenetic tree from the fastas in the BLAST results directory. The tree is built using "fasttree". The tree is stored in a ".tre" file, which is output to the "outputTrees" directory, in a subfolder that is based on the name of the organism.

# Where to access the data

This script does not have many data dependencies. You simply need to supply an organism name. However, it might be a good idea to do a manual search query on the NCBI website to verify that there is at least some gene information for your organism on their site. The URL to verify this is:

https://www.ncbi.nlm.nih.gov/nucleotide/

# How to run

The process may be ran by running the "main.sh" script in the root directory of the repository. The script requires an organism parameter. Here is an example of running the main script on Saccharomyces cerevisiae:

```
./main.sh "Saccharomyces cerevisiae"
```
