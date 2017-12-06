#!/usr/bin/env bash

# download Docker Compose, copying it to /usr/local/bin
sudo curl --location https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-Linux-x86_64 --output /usr/local/bin/docker-machine

# make the file executable
sudo chmod +x /usr/local/bin/docker-machine

# verify Docker Machine is in the path
which docker-machine

# verify Docker Machine version
docker-machine --version
