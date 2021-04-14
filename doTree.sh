#!/bin/bash

# get path to where fastas were output to
fastas_directory="pullFiles/fastas"

# create tree from the retrieved fastas and output it to the output folder
echo "Building tree"
fa2tree.py -i $fastas_directory -t fasttree -s -A PAS1855 -o outputTrees
echo "Tree completed."

# TODO display the output
