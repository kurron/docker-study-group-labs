#!/usr/bin/env bash

HOST=${1:-172.31.28.34}

CMD="ssh -i study-group ubuntu@${HOST} sudo usermod -aG docker ubuntu"
echo ${CMD}
${CMD}

FIXED="ssh -i study-group ubuntu@${HOST} docker info"
echo ${FIXED}
${FIXED}
