
from Bio import Entrez
import sys
import os 
import shutil

inputOrganism = sys.argv[1]
downloadName = sys.argv[2]

Entrez.email = "nomiotek@osu.edu"
search_handle = Entrez.esearch(
db = "nuccore",
term = (inputOrganism + "[Organism]"),
retmax = 20)
search_results = Entrez.read(search_handle)
search_handle.close()
# print(search_results)
id_list = search_results["IdList"]
if len(id_list) > 0:  # only get the fasta if there is an ID to retrieve

    # download each id as a separate fasta to compare file sizes
    # blasting works better with less specific / shorter sequences?
    tempDir = "tempDir"
    os.mkdir(tempDir)
    dwn = os.path.splitext(os.path.basename(downloadName))
    for i in id_list:
        search_handle = Entrez.efetch(db = "nuccore",
                                    rettype = "fasta",
                                    id = [i])
        temp_name = dwn[0] + "_" + str(i) + dwn[1]
        with open(tempDir + "/" + temp_name, "w") as fhandle_out:
            for line in search_handle:
                fhandle_out.write(line)
        search_handle.close()

    # copy the fasta that is being used to the requested spot
    # assume to use the largest retrieved fasta
    listed = os.listdir(tempDir)
    smallestSize = ""
    smallestBytes = 0
    for l in listed:
        sz = os.path.getsize(tempDir + "/" + l)
        if sz > smallestBytes:
            smallestSize = l
            smallestBytes = sz

    shutil.copy(tempDir + "/" + smallestSize, "pullFiles/" + downloadName)
    
    # delete the temp directory
    for l in listed:
        os.remove(tempDir + "/" + l)
    os.rmdir(tempDir)
