FROM hlapp/rpopgen
WORKDIR /home/rstudio
RUN R -e "install.packages('vcfR')"
VOLUME /home/ashbya
