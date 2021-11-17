#!/bin/bash 

docker build . -t 611-crocker

docker run --rm \
 -p 8080:8080 \
 -v $(pwd):/home/rstudio/\
 -d\
 -t 611-crocker\
 /bin/bash -c "cd proj; Rscript app.R"
