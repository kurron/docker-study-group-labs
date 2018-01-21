#!/usr/bin/env bash

# what tag to use on the image
TAG="${1-FIX-ME}"

# the docker command to build and tag the image
BUILD="docker ..."
echo ${BUILD}
${BUILD}
