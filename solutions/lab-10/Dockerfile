# select the base image to build upon
FROM ubuntu:16.04

# Leave a bread crumb in case people need help
MAINTAINER Ron Kurr "kurron@jvmguy.com"

# add environment variables to the environment
ENV FAVORITE_CHARACTER Cable

# establish the working directory
WORKDIR /

# skips the union file system
VOLUME ["/opt/can-be-shared"]

# cannot be overridden at container launch time
ENTRYPOINT ["/bin/ls"]

# can be overriden at container launch time
CMD ["-alh"]

# copy a local file into the container
ADD local.txt /opt/local.txt

# copy a remote file into the container
ADD http://wordpress.org/latest.zip /opt/wordpress.zip

# copy a local file into the container and automatically unpack it
ADD wordpress-4.8.3.tar.gz /opt

# copy local files into the container
COPY rsyslog.d/ /opt/

# add metadata to the container
LABEL location="New York" type="Data Center" role="Web Server"
