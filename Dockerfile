FROM hlapp/rpopgen
WORKDIR /home/rstudio
RUN R -e "install.packages(c('vcfR','shiny'))"
RUN mkdir images
RUN sudo usermod -aG sudo rstudio
