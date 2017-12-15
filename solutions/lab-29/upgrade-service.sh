#!/usr/bin/env bash

echo Install an "old" version of the container
DEPLOY="docker-machine ssh bravo docker service create --mode replicated \
                                                       --replicas 4 \
                                                       --name redis \
                                                       --update-delay 10s \
                                                       --network showcase \
                                                       redis:3.0.6"
echo ${DEPLOY}
${DEPLOY}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the service
INSPECT="docker-machine ssh bravo docker service inspect --pretty redis"
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
watch 'docker-machine ssh bravo docker service ps redis'

echo Upgrade to a newer version of the container
UPGRADE="docker-machine ssh bravo docker service update --image redis:3.0.7 redis"
echo ${UPGRADE}
${UPGRADE}

echo
echo Press a key to proceed
read -n 1 -s

echo ${INSPECT}
${INSPECT}

echo
echo Press a key to proceed
read -n 1 -s

echo List where the service is running
echo
watch 'docker-machine ssh bravo docker service ps redis'
