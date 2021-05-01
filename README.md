# Overview

The scripts to be written for the process are:

1. One to setup the folder structure (setup.sh)
2. One that will download a gene given an organism name (getFasta.py)
3. One that will BLAST the downloaded gene, and create a phylogenetic tree from the BLAST results (doBlast.sh)
5. A script that runs all the other scripts (main.sh)

More detail on the scripts can be found in project_documentation.md

# Work in progress 

* The overall process does not select for specific kinds of genes. It was mostly to gain familiarity with the general use of the tools. In the future, the search would be able to look for particular gene regions.
* The output tree is also not cleaned up. This will have to happen for a future version of this workflow.
