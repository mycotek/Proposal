
# Submission Notes

1. The workflow can be ran by running "main.sh" and supplying an organism name like:

    ./main.sh "Ginkgo biloba"

   If the given name is not an organism name, then it may not work correctly.

2. Any existing data in the "pullFiles" or "outputTree" files may be ignored. These are
   outputs from previous test runs

3. I modified one of the mycotool calls to use SLURM with its -s option. I was not
   sure if a SLURM job was allowed to create another SLURM job. 
   
