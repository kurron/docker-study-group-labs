# select the base image to build upon
FROM ubuntu:16.04

# Leave a bread crumb in case people need help
MAINTAINER Ron Kurr "kurron@jvmguy.com"

# Install Nginx via the package manager
RUN apt-get update; apt-get install --yes nginx

# Alternate form
# RUN [ "apt-get", " install", "--yes", "nginx" ]

# Provide Nginx with a default HTML file
RUN echo 'Hi, I am in your container' > /var/www/html/index.html

# Tell Docker what port on the "inside" of the container Nginx is bound to
EXPOSE 80
