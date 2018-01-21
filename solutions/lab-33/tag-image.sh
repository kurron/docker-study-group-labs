#!/usr/bin/env bash

# Tag the image, so it can be pushed to the AWS registry 

# image to tag
IMAGE=${1:-kurron/lab-33:v1.0.0}

# tag to apply
TAG=${2:-037083514056.dkr.ecr.us-west-2.amazonaws.com/aws-study-group:v1.0.0}

CMD="docker tag ${IMAGE} ${TAG}"
echo ${CMD}
${CMD}
