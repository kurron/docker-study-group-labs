#!/usr/bin/env bash

echo Install Nginx service
INSTALL="docker-machine ssh bravo docker service create --mode replicated \
                                                        --replicas 3 \
                                                        --name nginx \
                                                        --update-delay 10s \
                                                        --network showcase \
                                                        --constraint 'node.role==worker' \
                                                        --publish published=80,target=8080 \
                                                        kurron/spring-cloud-aws-echo:latest"
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

echo
echo List the status of all services
ALL="docker-machine ssh bravo docker service ls"
echo ${ALL}
${ALL}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo List who is running the Nginx containers
NGINX="docker-machine ssh bravo docker service ps nginx"
echo ${NGINX}
${NGINX}

echo
echo Press a key to proceed
read -n 1 -s

echo
echo Grab the IP address of Bravo
BRAVO="docker-machine ip bravo"
echo ${BRAVO}
export IP=$(docker-machine ip bravo)
echo ${IP}
