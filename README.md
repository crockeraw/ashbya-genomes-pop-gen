# BIOS 611 Project
## Population genetic analysis of *Ashbya gossypii* --- Alex Crocker 2021

## Who is *Ashbya gossypii*? 
*Ashbya* is a filamentous fungus and a pretty close relative of the brewers yeast and all-star model organism *Saccharomyces cerevisiae*. Although *Ashbya* is itself a faily popular model organism, only a couple of genomes are available on NCBI, and we still don't know much about its populations in nature. Here I am using new data to look at recombination, speciation, and other aspect of population structure in *Ashbya* isolated from insect and plant hosts. 

## What is the data I am working with?
In this project I am starting with a variant call file (VCF). VCFs list the differences between a reference sequence and sequences that are aligned to it. I have already produced a VCF with merged data from 48 wild isolates of the fungus *Ashbya gossypii*. For this project I subset the variant call file to include only the mitocondrial genome. Since it is relatively small I can host the data on Github, and you can run analyses on a laptop. 

## How can you run this project?
First you need to clone this repository. 

Use the terminal to navigate to where you would like to make a copy of this repository and type `$ git clone https://github.com/crockeraw/bios-611-project.git`.

You can either manually install all the dependencies, or the provided Dockerfile to create a virtual environment in which to reproduce this project. I strongly recommend creating the Docker container if you can.

### Create and run my Docker container
The easiest way to build and run the docker container is run the provided bash script (in a linux/mac terminal) `sudo bash ./start-rstudio.sh <custom-password>` and navigate to `localhost:8787` in a web browser. Your username will be Rstudio and password is the custom password you provided, or "foo" if none was given. \
\
If you do not want to create an Rstudio session you can simply run:
```
sudo docker build . -t 611-crocker
sudo docker run -it 611-crocker
```
### Build my project and generate a report
This project consists of images, datasets, and the R scripts that generate them; as well as an html report summarizing all findings. \
To build the entire project run the command `make`. This can be run in a terminal either in the Rstudio session accessed through the browser, or through an interative Docker session. 

### Run the Rshiny app
If you would like to run a shiny app to look at summary statistics of my data or your own data (vcf file, genomic fasta, and gff annotation file are required) you can launch the shiny app. Run the app by invoking `sudo bash start-shiny.sh`, or run it through the Rstudio session.
