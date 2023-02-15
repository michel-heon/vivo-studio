#!/bin/bash

###################################################################
# Script Name   :
# Description   :
# Args          :
# Author        : Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2022
# Email         : heon.michel@uqam.ca
###################################################################
export CF_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $CF_SCRIPT_DIR/../conf/vs-conf.sh
BS=$(basename $1 .json)
cd $CF_TEMPLATE
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
aws cloudformation describe-stacks --query "Stacks[?StackName=='"$STACK_NAME_ID"']" | tee