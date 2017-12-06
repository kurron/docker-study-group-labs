#!/usr/bin/env bash

# These need to match your account
REGION=${1:-us-west-2}

# Echo will be a worker node
CMD="./create-docker-machine.sh ${REGION} echo worker medium"
echo ${CMD}
${CMD}
