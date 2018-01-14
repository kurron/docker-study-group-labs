#!/usr/bin/env bash

# This script simulates using Docker as Function as a Service (FaaS)

CPU=${1:-1024}
RAM=${2:-128M}
SCRIPT_NAME=${3:-/faas/faas.py}
ENVIRONMENT_FILE=${4:-faas.env}
NETWORKING=${5:-none}
INPUT=${6:-'hi, ron'}

echo Run Groovy Function
RUN="docker run --cpu-shares ${CPU} \
                --entrypoint ${SCRIPT_NAME} \
                --env-file ${ENVIRONMENT_FILE} \
                --log-driver json-file \
                --log-opt max-file=1 \
                --log-opt max-size=1m \
                --memory ${RAM} \
                --memory-swap 0 \
                --name Python \
                --network ${NETWORKING} \
                --read-only \
                --rm \
                --volume $(pwd):/faas \
                --workdir /faas \
                python:3 ${INPUT}"
echo ${RUN}
${RUN}
