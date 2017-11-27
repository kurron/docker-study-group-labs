#!/usr/bin/env bash

# download Docker Compose, copying it to /usr/local/bin
sudo curl --location https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` --output /usr/local/bin/docker-compose

# make the file executable
sudo chmod +x /usr/local/bin/docker-compose

# verify Docker Compose is in the path
which docker-compose

# verify Docker Compose version 
docker-compose --version
