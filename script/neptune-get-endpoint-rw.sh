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
export NEP_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
# source $NEP_SCRIPT_DIR/../00-VARS/00-env-make.sh

aws neptune describe-db-cluster-endpoints \
    --query 'DBClusterEndpoints[?DBClusterIdentifier==`'"$NEPTUNE_CLUSTER_NAME"'`].Endpoint' --output=text | \
     tr -s '\t' '\n'| \
     tr -s ' ' '\n'| \
     grep -v '\-ro\-'
