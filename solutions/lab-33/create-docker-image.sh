#!/usr/bin/env bash

# what tag to use on the image
TAG="${1-kurron/lab-33:v1.0.0}"

# the docker command to build and tag the image
BUILD="docker build --tag=${TAG} ."
echo ${BUILD}
${BUILD}
