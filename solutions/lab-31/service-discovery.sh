#!/usr/bin/env bash

echo Install Nginx service
INSTALL="docker-machine ssh bravo docker service create --mode replicated \
                                                        --replicas 3 \
                                                        --name nginx \
                                                        --update-delay 10s \
                                                        --network showcase \
                                                        --endpoint-mode dnsrr \
                                                        nginx:latest"
echo ${INSTALL}
${INSTALL}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the service
INSPECT="docker-machine ssh bravo docker service inspect --pretty nginx"
echo ${INSPECT}
${INSPECT}

echo
echo Press a key to proceed
read -n 1 -s

echo Install Busybox Service
INSTALL_BB="docker-machine ssh bravo docker service create --mode replicated \
                                                           --replicas 1 \
                                                           --name busybox \
                                                           --update-delay 10s \
                                                           --network showcase \
                                                           busybox:latest sleep 3000"
echo ${INSTALL_BB}
${INSTALL_BB}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the service
INSPECT_BB="docker-machine ssh bravo docker service inspect --pretty busybox"
echo ${INSPECT_BB}
${INSPECT_BB}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Inspect the status of the services
STATUS="docker-machine ssh bravo docker service ls"
echo ${STATUS}
${STATUS}

echo
echo Press a key to proceed
read -n 1 -s

echo List where Busybox service is running
echo
LIST="docker-machine ssh bravo docker service ps busybox"
echo ${LIST}
${LIST}
