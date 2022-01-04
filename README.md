# Ashbya genomes project
## Population genetic analysis of *Ashbya spp.* --- Alex Crocker 2021

## Who is *Ashbya gossypii*? 
*Ashbya* is a filamentous fungus and a pretty close relative of the brewer's yeast and all-star model organism *Saccharomyces cerevisiae*. Although *Ashbya* is itself a pretty popular model organism, only a couple of genomes are publicly available, and we still don't know too much about its populations in nature. Here I am using new whole-genome sequencing data to look at population structure in *Ashbya* isolated from insect and plant hosts. This is a work in progess.

## What is the data I am working with?
The source data for this project inlcudes a variant call file (VCF) and a metadata file. The VCF lists the differences between the *Ashbya gossypii* reference genome and sequencing reads that were aligned to it. I have reason to believe that many of these isolates are actually closely related, non-*gossypii* species, which I hope to address in the future. The metadata file is included in this repo but **the VCF is very large and will be downloaded from a remote host when the Makefile is run**. This may take a while (~5 minutes).

## How can you run this project?
First you need to clone this repository. 
Use the terminal to navigate to where you would like to make a copy of this repository and type or paste `git clone https://github.com/crockeraw/ashbya-genomes-pop-gen.git`. To actually run the scripts to reproduce the analysis you will need to have Docker installed on your computer, or manually install of the dependencies (not yet listed). 

### Create and run my Docker container
The easiest and quickest way to build and interact with this project is by running the provided bash script (in a linux/mac terminal) by navigating to the project directory and typing `sudo bash start-rstudio.sh <custom-password>` and navigating to `localhost:8787` in a web browser. Your username will be Rstudio and password will be the custom password you provided, or "foo" if none was given. \
\
If you do not want to create an Rstudio session you can simply run:
```
sudo docker build . -t ashyba
sudo docker run -it ashbya
```
### Build my project and generate a report
This project consists of images, datasets, and the R scripts that generate them; as well as an html report summarizing all findings, and a shiny app to explore them. \
To build the entire project run the command `make`. This can be run in a terminal either in the Rstudio session accessed through the browser, or through an interative Docker session. To view the report simply open the file `derived_data/report.html` in your browser. 

### Use the Rshiny app
If you would like to run a shiny-app to visualize some aspects of the population structure you can launch it though the R console by typing `library(shiny); runApp(shinyapp)` in R, or you can access the app online here: https://alex-crocker.shinyapps.io/ashyba-pop-gen/?_ga=2.72639898.826599290.1641249641-868820857.1639163203
