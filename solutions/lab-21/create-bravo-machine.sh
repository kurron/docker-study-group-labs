#!/usr/bin/env bash

# These need to match your account
REGION=${1:-us-west-2}
ZONE=${2:-a}

# Bravo will be the console node
CMD="./create-docker-machine.sh ${REGION} bravo manager small ${ZONE}"
echo ${CMD}
${CMD}
