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
if [ -f "$STACK_NAME.json" ]; then
    export STACK_NAME_FN=$STACK_NAME.json
else
    export STACK_NAME_FN=$STACK_NAME.yaml
fi
echo "###################################################################"
echo "###################################################################"
echo "### APPEL de $0"
echo "###################################################################"
echo "## STACK_NAME    =$STACK_NAME"
echo "## STACK_NAME_ID =$STACK_NAME_ID"
echo "## STACK_NAME_FN =$STACK_NAME_FN"
echo "###################################################################"

if [ -f "$STACK_NAME-parameters.json" ]; then
    aws cloudformation update-stack --stack-name $STACK_NAME_ID --template-body file://$STACK_NAME_FN --parameters file://$STACK_NAME-parameters.json --capabilities CAPABILITY_NAMED_IAM
else
    aws cloudformation update-stack --stack-name $STACK_NAME_ID --template-body file://$STACK_NAME_FN --capabilities CAPABILITY_NAMED_IAM
fi



