#!/bin/bash

# import the environment with the dependencies
# if it doesn't exists and activate it
module load python/3.6-conda5.2
listed_envs=$(conda env list)
if [[ $listed_envs == *"mycotools-user"* ]]; then
  echo "mycotools-user conda environment already exists"
else
  echo "creating mycotools-user conda environment"
  conda env create -f environment.yml
fi

# mycodb_path=$(mycodb)  # put mycodb path into its own variable (command currently not working)
# echo "Mycodb path is $mycodb_path"

mkdir -p pullFiles   # directory for downloaded files
mkdir -p outputTrees # directory for the created phylogenetic trees
