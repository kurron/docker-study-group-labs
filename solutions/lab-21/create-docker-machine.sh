#!/usr/bin/env bash

INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type)
INTERFACE=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
SUBNET_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/subnet-id)
VPC_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/vpc-id)

# These need to match your account
REGION=${1:-us-west-2}
NAME=${2:-alpha}
ROLE=${3:-console}
SIZE=${4:-small}
ZONE=${5:-a}


# Can anyone spot missing information usually required to create an EC2 instance?
CMD="docker-machine create --driver amazonec2 \
                           --amazonec2-instance-type ${INSTANCE_TYPE} \
                           --amazonec2-region ${REGION} \
                           --amazonec2-zone ${ZONE} \
                           --amazonec2-ssh-keypath ./study-group \
                           --amazonec2-tags Name,${NAME},Project,study-group \
                           --amazonec2-subnet-id ${SUBNET_ID} \
                           --amazonec2-vpc-id ${VPC_ID} \
                           --engine-label size=${SIZE} \
                           --engine-label role=${ROLE} \
                           ${NAME}"
echo ${CMD}
${CMD}
