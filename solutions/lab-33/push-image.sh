#!/usr/bin/env bash

# Push the image to the Amazon registry 

IMAGE=${1:-037083514056.dkr.ecr.us-west-2.amazonaws.com/aws-study-group:v1.0.0}

CMD="docker push ${IMAGE}"
echo ${CMD}
${CMD}
