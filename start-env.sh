#!/bin/bash 

docker build . -t 611-crocker

docker run --rm \
 -p 8787:8787 \
 -p 8080:8080 \
 -e PASSWORD=${1:-foo}
 -v $(pwd):/home/rstudio/proj/\
 -d\
 -t 611-crocker > /tmp/docker-output

echo login to Rstudio using the address localhost:8787 in a web browser. Your username is Rstudio, your password is ${1:-foo}.
