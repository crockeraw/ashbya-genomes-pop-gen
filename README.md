# BIOS 611 Project
## Population genetic analysis of *Ashbya gossypii* --- Alex Crocker 2021

## Who is *Ashbya gossypii*? 
*Ashbya* is a filamentous fungus and a pretty close relative of the brewers yeast and all-star model organism *Saccharomyces cerevisiae*. Although *Ashbya* is itself a faily popular model organism, only a couple of genomes are available on NCBI, and we still don't know much about its populations in nature. Here I am using new data to look at recombination, speciation, and other aspect of population structure in *Ashbya* isolated from insect and plant hosts. 

## What is the data I am working with?
In this project I am starting with a variant call file (VCF). VCFs list the differences between a reference sequence and sequences that are aligned to it. I have already produced a VCF with merged data from 48 wild isolates of the fungus *Ashbya gossypii*. For this project I subset the variant call file to include only the mitocondrial genome. Since it is relatively small I can host the data on Github, and run analyses on a laptop. 

## How can you run this project?
First you need to clone this repository. From the top level of the repo you can...  
You can build my full project including reports and figures (which do not yet exist) by running "make".   
If you would like to run a shiny app to look at summary statistics of my data or your own data (vcf file, genomic fasta, and gff annotation file are required) you can launch the shiny app. Run the app by invoking "sudo bash start-shiny.sh".  
If you would like to start an rstudio session in my working environment, use "sudo bash start-rstudio.sh".  
