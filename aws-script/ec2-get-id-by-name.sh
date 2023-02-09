#!/bin/bash
###################################################################
# Script Name   :
# Description   :
# Args          : 
# Author       	: Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2021
# Email         : heon.michel@uqam.ca
###################################################################
export EC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $EC_SCRIPT_DIR/../conf/vs-conf.sh
usage() { echo "Usage: $0 <nom-de-l_instance> " 1>&2; exit 1; }
[ -z "$1" ] && usage 
export INSTANCE_NAME=$1
aws ec2 describe-instances --filters  "Name=tag:Name,Values=$INSTANCE_NAME" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].InstanceId" --output=text
