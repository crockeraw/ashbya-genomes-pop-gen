#!/bin/bash 

docker build . -t core-genome

docker run --rm \
 -p 8888:8787 \
 -p 3333:3333\
 -e PASSWORD=${1:-foo}\
 -v $(pwd):/home/rstudio/\
 -d\
 -t core-genome 
echo login to Rstudio using the address localhost:8787 in a web browser. Your username is Rstudio, your password is ${1:-foo}.
