#!/usr/bin/env bash

echo Deploying a replicated service
DEPLOY="docker-machine ssh bravo docker service create --mode replicated --replicas=2 --name hello-replicated alpine ping docker.com"
echo ${DEPLOY}
${DEPLOY}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the service
INSPECT="docker-machine ssh bravo docker service inspect --pretty hello-replicated"
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
watch 'docker-machine ssh bravo docker service ps hello-replicated'
