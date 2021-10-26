#!/bin/bash 

docker build . -t 611-crocker

export R_PASS=$(strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo)

docker run --rm \
 -p 8787:8787 \
 -p 8080:8080 \
 -e PASSWORD=$R_PASS
 -v $(pwd):/home/rstudio/proj/\
 -d\
 -t 611-crocker > /tmp/docker-output

echo login to Rstudio using the address localhost:8787 in a web browser. Your username is Rstudio, your password is $R_PASS.
