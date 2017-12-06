#!/usr/bin/env bash

#docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws-sandbox

AMI=$(curl --silent http://169.254.169.254/latest/meta-data/ami-id)
INSTANCE_TYPE=$(curl --silent http://169.254.169.254/latest/meta-data/instance-type)
INTERFACE=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
SUBNET_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/subnet-id)
VPC_ID=$(curl --silent http://169.254.169.254/latest/meta-data/network/interfaces/macs/${INTERFACE}/vpc-id)
SECURITY_GROUP_ID="sg-ef8dc992"

CMD="docker-machine create --driver amazonec2 \
                           --amazonec2-ami ${AMI} \
                           --amazonec2-instance-type ${INSTANCE_TYPE} \
                           --amazonec2-region us-east-1 \
                           --amazonec2-ssh-keypath ./study-group \
                           --amazonec2-ssh-user ubuntu \
                           --amazonec2-tags Name,alpha,project,study-group \
                           --amazonec2-subnet-id ${SUBNET_ID} \
                           --amazonec2-vpc-id ${VPC_ID} \
                           --amazonec2-security-group ${SECURITY_GROUP_ID} \
                           --engine-label size=small \
                           --engine-label role=console \
                           alpha"
echo ${CMD}
${CMD}
