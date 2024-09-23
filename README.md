# Summer-Project-2024

The project starts with GeoSearch.Rmd which contains code that finds and retrieves all data from GEO

The Rmd files Open_AI_(GPT3.5) and Open_AI_(GPT4o) contain functions for the OpenAI API models that is used in GeoSearch.Rmd

The shell scripts were used in Elja to organise the SRR files and download them and to then run kallisto. 
  -We first begin by sorting all of the SRR IDs using sort_SRR_fastq.sh
  -We then download the SRR IDs using download_SRR.sh
  -We then run Kallisto_quant.sh which calls the other kallisto-sh-files according to criteria.

After having exported the files from Elja we can import them onto our local computer and run Deseq2.rmd

Finally we to some gene_ontology.

