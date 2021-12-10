FROM hlapp/rpopgen
WORKDIR /home/rstudio
RUN R -e "install.packages(c('vcfR','shiny'))"
RUN  apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN sudo usermod -aG sudo rstudio