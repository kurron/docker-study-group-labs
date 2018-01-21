#!/usr/bin/env bash

# Run the image, verifying that it works as expected 

IMAGE=${1:-kurron/lab-33:v1.0.0}

RUN="docker run --name Test \
                --network none \
                --read-only \
                --rm \
                ${IMAGE}"
echo ${RUN}
${RUN}
