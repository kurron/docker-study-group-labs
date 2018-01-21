#!/usr/bin/env bash

# Tag the image, so it can be pushed to the AWS registry 

# image to tag
IMAGE=${1:-FIX-ME}

# tag to apply
TAG=${2:-FIX-ME}

# Docker command to apply the tag to the image
CMD="docker ..."
echo ${CMD}
${CMD}
