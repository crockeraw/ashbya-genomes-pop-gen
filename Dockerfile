FROM hlapp/rpopgen
WORKDIR /home/rstudio/proj
RUN R -e "install.packages(c('vcfR','shiny'))"
RUN sudo usermod -aG sudo rstudio
