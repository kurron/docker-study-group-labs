#!/usr/bin/env bash

echo Creating overlay network for the application containers

CREATE="docker-machine ssh bravo docker network create --driver overlay showcase"
echo ${CREATE}
${CREATE}

LS="docker-machine ssh bravo docker network ls"
echo ${LS}
${LS}

echo
echo Press a key to proceed
read -n 1 -s

INSPECT="docker-machine ssh bravo docker network inspect showcase"
echo ${INSPECT}
${INSPECT}
