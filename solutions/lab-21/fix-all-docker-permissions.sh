#!/usr/bin/env bash

INSTANCES='alpha bravo charlie delta echo'

for i in $INSTANCES
do
  ./fix-docker-permissions.sh $(aws ec2 describe-instances --filters "Name=tag:Name,Values=${i}" --query Reservations[].Instances[].NetworkInterfaces[].Association[].PublicIp --output=text)

done

