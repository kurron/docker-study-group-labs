#!/usr/bin/env bash

# This script simulates using Docker as Function as a Service (FaaS)

CPU=${1:-1024}
RAM=${2:-128M}
SCRIPT_NAME=${3:-/faas/faas.groovy}
ENVIRONMENT_FILE=${4:-faas.env}
NETWORKING=${5:-none}
INPUT=${6:-'hi, ron'}

echo Run Groovy Function
RUN="docker run ..."
echo ${RUN}
${RUN}
