#!/bin/bash

echo "Running test"
# this will be for testing the workflow
# downloaded from https://www.ncbi.nlm.nih.gov/nuccore/NC_024555.1?from=44999&to=45616&report=fasta
test_input="/fs/ess/PAS1855/users/nomiotek/project/test-Heterobasidion-irregulare.fasta"

./main.sh $test_input
