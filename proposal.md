# Project Proposal


# General Description

This project will be to learn how to use MycoTools and to create a pipeline that will use a fasta file as it is input for a select gene. A phylogenetic tree will be created to show how that specific gene is related in one more than species of fungi. BLAST will be used in the pipeline to compare against MycoDB to gather fasta files, then a phyologenetic tree will be created from these fasta files.


# Technical Aspects

The primary language will be in Bash, and most of the processing will be performed via external Python scripts retrieved from Mycotools. The main tools that will be used are MycoDB BLAST in order to BLAST a fasta file, and Fasta to tree which will be used to produce a phylogenetic tree. The fasta files that are created will be saved into a newly created folder so they can be looked at. Any runs of this will be written to a new folder with a newly created name.


# Graded Aspects that may be skipped or not sure will be fulfilled

My hope is to be able to use these tools that Zach provided in order to produce a phylogenetic tree comparing genes, and through that ultimately using SLURM. Since I was just recently introduced to these tools I need to meet with Zach and discuss exactly how I may use SLURM to fulfill this aspect of the project. 

# Aspects of the project I am uncertain about

Since the MycoTools is a new toolset to me, the challenge of this will be to learn how to utilize these tools so that the Bash script can work with it. As of right now, I am not sure what particular gene I want to look at for fungi. I am going to spend some time searching for a gene that is found in various fungi. This is so I have enough species to compare in a phylogenetic tree to make it valuable. 

# Why I chose to pick this project

I chose this because I am interested in fungal genomes. I am interested in learning this new tool to be able to understand the evolutionary history of fungi. I want to be able to learn and automate the creation of phylogenetic trees for them. 


