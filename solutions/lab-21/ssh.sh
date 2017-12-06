#!/usr/bin/env bash

HOST=${1:-172.31.28.34}

CMD="ssh -i study-group ubuntu@${HOST}"
echo ${CMD}
${CMD}
