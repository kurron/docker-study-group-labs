#!/usr/bin/env bash

echo Remove the service
DEPLOY="docker-machine ssh bravo docker service rm hello-global"
echo ${DEPLOY}
${DEPLOY}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo List the logical status of the global service
STATUS="docker-machine ssh bravo docker service ls"
echo ${STATUS}
${STATUS}
