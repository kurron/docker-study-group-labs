#!/usr/bin/env bash

docker stop $(docker ps --quiet)
docker rm --volumes --force $(docker ps --all --quiet)
docker rmi --force $(docker images --quiet)
