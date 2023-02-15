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
BS=$(basename $1 .json)
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
echo Wait delete
$CF_SCRIPT_DIR/stack-delete.sh $1
echo Create Stack
$CF_SCRIPT_DIR/stack-create.sh $1

