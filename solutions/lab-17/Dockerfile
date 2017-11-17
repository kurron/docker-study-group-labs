FROM ubuntu:16.04

MAINTAINER Ron Kurr "kurron@jvmguy.com"

RUN apt-get update && apt-get --yes install curl

RUN curl --silent --location --output docker.tgz http://get.docker.com/builds/Linux/x86_64/docker-latest.tgz

RUN tar --extract --verbose --gunzip --file docker.tgz

RUN mv --verbose docker/* /usr/bin/

CMD ["docker", "--version"]
