#!/usr/bin/env bash

# These need to match your account
REGION=${1:-us-west-2}

# Delta will be a worker node
CMD="./create-docker-machine.sh ${REGION} delta worker medium"
echo ${CMD}
${CMD}
