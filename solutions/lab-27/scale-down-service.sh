#!/usr/bin/env bash

echo Scale down the constrained service
DEPLOY="docker-machine ssh bravo docker service scale hello-constrained=1"
echo ${DEPLOY}
${DEPLOY}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the service
INSPECT="docker-machine ssh bravo docker service inspect --pretty hello-constrained"
echo ${INSPECT}
${INSPECT}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo List the logical status of the global service
STATUS="docker-machine ssh bravo docker service ls"
echo ${STATUS}
${STATUS}

echo
echo Press a key to proceed
read -n 1 -s

echo List where the service is running
echo
watch 'docker-machine ssh bravo docker service ps hello-constrained'
