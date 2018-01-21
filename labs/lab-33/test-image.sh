#!/usr/bin/env bash

# Run the image, verifying that it works as expected 

IMAGE=${1:-FIX-ME}

# run the image, testing it
RUN="docker ..."
echo ${RUN}
${RUN}
