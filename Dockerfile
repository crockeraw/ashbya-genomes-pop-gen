FROM hlapp/rpopgen
WORKDIR /home/rstudio
RUN R -e "install.packages(c('vcfR','shiny'))"
VOLUME /home/ashbya
