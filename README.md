# Overview
This document contains the steps that were covered in the
[Docker 101](https://classroom.google.com/c/NTk3MDEyOTcxM1pa) labs.
Useful if you missed a class or forgot a step.

# Prerequisites
* An AWS account
* An SSH client, [OpenSSH](https://www.openssh.com/) preferred
* Basic Linux knowledge preferred

# Tmux Cheat Sheet
* `ctrl-b C` -- create new window
* `ctrl-b n` -- jump to next window
* `ctrl-b p` -- jump to previous window
* `ctrl-b 0` -- jump to 0th window
* `ctrl-b ""` -- split window horizontally (pane)
* `ctrl-b O` -- jump to next pane
* `ctrl-b x` -- close pane

# Lab 1: Installation

## Ubuntu Linux (manual)
1. Spin up a small EC2 instance using the Ubuntu Linux AMI
1. `uname -a` to verify we are running a Linux 3.1.0 or higher kernel
1. `sudo apt-get install apt-transport-https ca-certificates curl software-properties-common`
1. `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
1. `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
1. `sudo apt-get update`
1. `sudo apt-get install docker-ce`
1. `sudo docker info`
1. destroy the instance

## Ubuntu Linux (automated)
1. Spin up a small EC2 instance using the Ubuntu Linux AMI
1. `uname -a` to verify we are running a Linux 3.1.0 or higher kernel
1. `sudo apt-get update`
1. `whereis curl`
1. `sudo apt-get install curl`
1. `curl https://get.docker.com/ | sudo sh`
1. `sudo docker info`
1. `docker info`
1. `sudo usermod -aG docker ubuntu`
1. `docker info`
1. log out and back in again
1. `docker info`
1. save the instance (we'll be using it in future labs)

# Lab 2: Kicking The Tires
1. Spin up a Ubuntu EC2 instance with Docker installed
1. ~~`sudo status docker`~~
1. ~~`status docker`~~
1. `cat /etc/group`
1. `docker info`
1. `sudo service docker stop`
1. `sudo service docker start`
1. `docker help`
1. `man docker`
1. `docker help run`
1. `docker run --help`
1. `docker run --interactive --tty ubuntu /bin/bash`
1. start a second ssh session to your EC2 instance (`tmux` can simplify this)
1. compare results of commands from inside Docker and on the EC2 instance
  1. `whoami`
  1. `hostname`
  1. `cat /etc/hosts`
  1. `hostname --all-ip-addresses`
  1. `ps -aux`
  1. `uname -a`
  1. `top`
  1. `ls /bin`
  1. `sudo find / -type d | wc --lines` -- **no `sudo`** needed on the Docker side
  1. `cat /proc/cpuinfo`
  1. `cat /proc/meminfo`
  1. `cat /proc/net/dev`
1. in your Docker container, `apt-get update; apt-get install vim`
1. in your Docker container, `exit`

# Lab 3: Manipulating Containers
. `docker ps` -- show running containers
1. `docker ps --all` -- show all containers
1. `docker ps --latest` -- show the last running container
1. `docker run --name wolverine --interactive --tty ubuntu /bin/bash`
1. `exit` the container
1. `docker ps --latest` -- notice the container name
1. `docker start wolverine` -- start stopped container
1. `docker ps` -- should see the wolverine container running
1. `docker attach <container id>` -- see how few characters you can get away with
1. `exit` to stop the container

# Lab 4: Manipulating Containers (continued)
1. `docker run --detach --name nightcrawler ubuntu /bin/sh -c "while true; do echo hello world; sleep 2; done"`
1. `docker logs --follow --timestamps nightcrawler`
1. `docker top nightcrawler`
1. `docker stats nightcrawler`
1. `docker exec --detach nightcrawler touch /etc/new_config_file`
1. `docker exec --interactive --tty nightcrawler /bin/bash`
1. `ls -alh /etc/new_config_file` -- should see the file added previously
1. `exit`
1. `docker stop nightcrawler`
1. `docker ps -a` -- container still exists but is not running
1. `docker run --restart=always --detach --name banshee ubuntu /bin/sh -c "sleep 2; exit 1964"`
1. `watch docker ps` -- notice how the container keeps restarting after the "failure"
1. `docker stop banshee`
1. `docker run --restart=on-failure:5 --detach --name colossus ubuntu /bin/sh -c "sleep 5; exit 1964"`
1. `watch docker ps` -- notice how Docker gives up restarting after 5 tries
1. `docker inspect colossus`
1. `docker inspect --format='{{ .State.Running }}' colossus`
1. `docker stop colossus`
1. `docker rm colossus`
1. clean up the remaining containers on your own. Try using id and names.
1. `docker rm --volumes --force $(docker ps --all --quiet)` -- shell magic to nuke all containers

# Lab 5: Docker Repository
1. visit `https://hub.docker.com/`
1. create an account (we'll use it in later labs)
1. click the `Explore` link
1. browse through the images marked as *official*
1. poke around the following images looking for differences between them
1. `docker run --interactive --tty alpine /bin/bash`
1. `docker run --interactive --tty centos /bin/bash`
1. `docker run --interactive --tty amazonlinux /bin/bash`
1. `docker run --interactive --tty bash /bin/bash`
1. `docker run --interactive --tty clearlinux /bin/bash`

# Lab 6: Docker Images
1. `docker images`
1. `docker run --interactive --tty ubuntu:16.04`
1. `docker run --interactive --tty ubuntu:14.04`
1. `docker run --interactive --tty ubuntu:latest`
1. `docker pull ubuntu:12.04`
1. `docker images`
1. `docker search python`
1. `docker search kurron`
1. `docker run --interactive --tty kurron/docker-azul-jdk-8-build /bin/bash`
1. `java -version`
1. `ansible --version`
1. `docker --version`
1. `exit`
1. `docker images`
1. `docker rmi --force $(docker images --quiet)`
1. `docker images`

# Lab 7: Creating Docker Images (the hard way)
1. `docker run --interactive --tty ubuntu:latest`
1. `apt-get update`
1. `apt-get install apache2`
1. `exit`
1. `LAST=$(docker ps --latest --quiet)`
1. `echo ${LAST}`
1. `docker commit ${LAST} kurron/apache2` <--- use your own repository account
1. `docker images kurron/apache2`
1. `docker commit --message "Created by hand" --author "Ron Kurr kurron@jvmguy.com" ${LAST} kurron/apache2:by-hand`
1. `docker inspect kurron/apache2:by-hand`
1. `docker run --interactive --tty kurron/apache2:by-hand`
1. `service apache2 status`

# Lab 8: Creating Docker Images (an easier way)
1. `git clone https://github.com/kurron/docker-study-group-labs.git`
1. `cd docker-study-group-labs/solutions/lab-07`
1. `docker build --tag="kurron/static_web:v1.0.0" .`
1. `docker images`
1. `docker build --file Dockerfile.broken .`
1. `docker build --no-cache --tag="kurron/static_web:v1.0.0" .`
1. `docker history 85098924c514` <--- your image id will be different

# Lab 9: Fun With Port Bindings
1. `docker run --detach --publish 80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker ps --latest`
1. `docker port cb888707fcba`
1. `docker port domino 80`
1. `docker run --detach --publish 80:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 8080:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 127.0.0.1:8080:80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker run --detach --publish 127.0.0.1::80 --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. stop and remove all containers
1. `docker run --detach --publish-all --name domino kurron/static_web:v1.0.0 nginx -g "daemon off;"`
1. `docker port domino`
1. `curl localhost:32769` <--- your port will be different

# Lab 10: Dockerfile Madness
1. `cd solutions/lab-10`
1. `docker build --tag="kurron/dockerfile-example:v1.0.0" .`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0 -alh /opt`
1. `docker run --interactive --tty kurron/dockerfile-example:v1.0.0 -alh /opt/wordpress`
1. `docker images`
1. `docker inspect kurron/dockerfile-example:v1.0.0`

# Lab 10: Publishing Docker Images
1. `cd labs/lab-11`
1. edit the `Dockerfile` and `local.txt` files, using your personal settings
1. `docker build --tag="kurron/publish-example:v1.0.0" .` <--- use your own account
1. `docker run --interactive --tty publish-example:v1.0.0`
1. `docker push kurron/publish-example:v1.0.0`
1. `docker login`
1. `docker push kurron/publish-example:v1.0.0`
1. visit [https://hub.docker.com/](https://hub.docker.com/) and find your image
1. run somebody else's image, illustrating how image sharing works

# Lab 11: Automated Image Building
This is difficult to explain in text so try and be in class for this one.

1. Create a [GitHub](https://github.com/) account if you don't already have one
1. Create a new repository using the `labs/lab-11` folder as source
1. Log into your [Docker Hub](https://hub.docker.com) account
1. click `Create -> Create Automated Build`
1. `Add Repository`
1. Add your GitHub account
1. Select your repository
1. `Create` to create the build project
1. Verify that the build was successful
1. Checkout your GitHub project
1. Make an edit to your `local.txt`
1. `git commit -am 'Ron made me do this'`
1. `git push`
1. In the Docker Hub console, make sure your Docker build gets triggered
1. Pull down the latest image and run it, ensuring your changes show up

# Lab N: Amazon EC2 Container Registry
# Lab N: Personal Image Registry (4.8)
# Lab N: Dockerfile Madness (advanced) (4.5.10.10)
# Lab N: Docker Log Drivers (3.9)
# Lab N: Guts
1. /var/lib/docker/containers (3.15)
1. /var/lib/docker (4.2)
1.

# Tips and Tricks

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
