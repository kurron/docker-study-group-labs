FROM ubuntu:16.04

MAINTAINER Ron Kurr "kurron@jvmguy.com"

RUN apt-get update; apt-get --yes install nginx

ADD global.conf /etc/nginx/conf.d/

ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
