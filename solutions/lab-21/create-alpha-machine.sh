#!/usr/bin/env bash

#docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws-sandbox

INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type)
INTERFACE=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
SUBNET_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/subnet-id)
VPC_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/vpc-id)
NAME="alpha"
# These need to match your account
REGION="us-west-2"

# Can anyone spot missing information usually required to create an EC2 instance?
CMD="docker-machine create --driver amazonec2 \
                           --amazonec2-instance-type ${INSTANCE_TYPE} \
                           --amazonec2-region ${REGION} \
                           --amazonec2-ssh-keypath ./study-group \
                           --amazonec2-tags Name,${NAME},project,study-group \
                           --amazonec2-subnet-id ${SUBNET_ID} \
                           --amazonec2-vpc-id ${VPC_ID} \
                           --engine-label size=small \
                           --engine-label role=console \
                           ${NAME}"
echo ${CMD}
${CMD}
