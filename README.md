# Overview
This document contains the steps that were covered in the
[Docker 101](https://classroom.google.com/c/NTk3MDEyOTcxM1pa) labs.
Useful if you missed a class or forgot a step.

# Prerequisites
* An AWS account
* An SSH client, [OpenSSH](https://www.openssh.com/) preferred
* Basic Linux knowledge preferred

# Lab 1: Installation

## Ubuntu Linux
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


# Tips and Tricks

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
