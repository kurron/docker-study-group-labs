#!/usr/bin/env bash

#docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws-sandbox

CMD="docker-machine create --driver amazonec2 \
                           --amazonec2-ami FOO \
                           --amazonec2-instance-type t2.nano \
                           --amazonec2-region us-east-1 \
                           --amazonec2-ssh-keypath ./study-group \
                           --amazonec2-ssh-user ubuntu \
                           --amazonec2-tags Name,alpha,project,study-group \
                           --amazonec2-vpc-id FOO \
                           alpha"
echo ${CMD}
