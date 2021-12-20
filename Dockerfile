FROM hlapp/rpopgen
WORKDIR /home/rstudio
RUN Rscript -e "install.packages(c('vcfR','shiny'))"
RUN Rscript -e 'requireNamespace("BiocManager"); BiocManager::install();' \
&& Rscript -e 'requireNamespace("BiocManager"); BiocManager::install("VariantAnnotation")' 
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN sudo usermod -aG sudo rstudio
