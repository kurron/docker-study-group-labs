#!/usr/bin/env bash

echo Put delta into maintenance mode
DRAIN="docker-machine ssh bravo docker node update --availability drain delta"
echo ${DRAIN}
${DRAIN}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the node
INSPECT="docker-machine ssh bravo docker node inspect --pretty delta"
echo ${INSPECT}
${INSPECT}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the status of the Swarm
STATUS="docker-machine ssh bravo docker node ls"
echo ${STATUS}
${STATUS}

echo
echo Press a key to proceed
read -n 1 -s

echo Monitor the transition between versions
echo
MONITOR="docker-machine ssh bravo docker service ps redis"
echo ${MONITOR}
watch ${MONITOR}

echo Put delta into active mode
ACTIVE="docker-machine ssh bravo docker node update --availability active delta"
echo ${ACTIVE}
${ACTIVE}

echo
echo Press a key to proceed
read -n 1 -s

echo Inspect the node
echo ${INSPECT}
${INSPECT}

echo
echo Press a key to proceed
read -n 1 -s

echo Inspect the status of the Swarm
echo ${STATUS}
${STATUS}

echo See where the containers are deployed
echo ${MONITOR}
watch ${MONITOR}
