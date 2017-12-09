#!/usr/bin/env bash

BRAVO_IP=$(docker-machine ip bravo)
echo "Bravo's IP address is ${BRAVO_IP}"

echo Creating the Swarm, making Bravo the Manager
BRAVO_COMMAND="docker-machine ssh bravo docker swarm init --advertise-addr ${BRAVO_IP}"
echo ${BRAVO_COMMAND}
${BRAVO_COMMAND}

echo Capture the manager and worker tokens
MANAGER_TOKEN=$(docker-machine ssh bravo docker swarm join-token --quiet manager)
WORKER_TOKEN=$(docker-machine ssh bravo docker swarm join-token --quiet worker)
echo Manager Token is ${MANAGER_TOKEN}
echo Worker Token is ${WORKER_TOKEN}

echo Joining remaining nodes to the Swarm as Workers
CHARLIE_COMMAND="docker-machine ssh charlie docker swarm join --token ${WORKER_TOKEN} ${BRAVO_IP}"
echo ${CHARLIE_COMMAND}
${CHARLIE_COMMAND}

DELTA_COMMAND="docker-machine ssh delta docker swarm join --token ${WORKER_TOKEN} ${BRAVO_IP}"
echo ${DELTA_COMMAND}
${DELTA_COMMAND}

ECHO_COMMAND="docker-machine ssh echo docker swarm join --token ${WORKER_TOKEN} ${BRAVO_IP}"
echo ${ECHO_COMMAND}
${ECHO_COMMAND}

sleep 5

echo List nodes in the Swarm
LS_COMMAND="docker-machine ssh bravo docker node ls"
echo ${LS_COMMAND}
${LS_COMMAND}

