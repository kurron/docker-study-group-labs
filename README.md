# Overview
This document contains the steps that were covered in the
[Docker 101](https://classroom.google.com/c/NTk3MDEyOTcxM1pa) labs.
Useful if you missed a class or forgot a step.

# Prerequisites
* An AWS account
* An SSH client, [OpenSSH](https://www.openssh.com/) preferred
* Basic Linux knowledge preferred

# Lab 1: Installation

## Ubuntu Linux (manual)
1. Spin up a small EC2 instance using the Ubuntu Linux AMI
1. `uname -a` to verify we are running a Linux 3.1.0 or higher kernel
1. `sudo apt-get update`
1. `sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual`
1. `sudo update-grub`
1. `sudo reboot`
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
1. `sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual`
1. `sudo update-grub`
1. `sudo reboot`
1. `whereis curl`
1. `sudo apt-get install curl`
1. `curl https://get.docker.com/ | sudo sh`
1. stop the instance (we'll be using it in future labs)

# Lab 2: Kicking The Tires
1. Spin up a Ubuntu EC2 instance with Docker installed
1. `sudo status docker`
1. `status docker`
1. `cat /etc/group`
1. `docker info`
1. `sudo service docker stop`
1. `sudo service docker start`
1. `docker run --help`
1. `docker run --hostname inside-docker --interactive --tty ubuntu /bin/bash`
1. start a second ssh session to your EC2 instance
1. compare results of commands from inside Docker and on the EC2 instance
  1. `ps -aux`
  1. `uname -a`
  1. `top`
1. in your Docker container, `exit`
1. `docker ps`
1. `docker ps -a`
1. `docker images`

# Lab 3: Docker Repository
1. visit `https://hub.docker.com/`
1. create an account (we'll use it in later labs)
1. click the `Explore` link
1. browse through the images marked as *official*
1. `docker run --hostname inside-docker --interactive --tty alpine /bin/bash`
1. `docker run --hostname inside-docker --interactive --tty centos /bin/bash`
1. `docker run --hostname inside-docker --interactive --tty amazonlinux /bin/bash`
1. `docker run --hostname inside-docker --interactive --tty bash /bin/bash`
1. `docker run --hostname inside-docker --interactive --tty clearlinux /bin/bash`


# Tips and Tricks

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
