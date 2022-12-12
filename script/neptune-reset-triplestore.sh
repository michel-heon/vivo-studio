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
source $NEP_SCRIPT_DIR/../conf/root-conf.sh

TOKEN=$(curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' https://$NEPTUNE_SPARQL_RW_HOST:8182/system -d 'action=initiateDatabaseReset' | jq '.payload.token' -r)
echo $TOKEN
sleep 5
curl -X POST -H 'Content-Type: application/x-www-form-urlencoded' https://$NEPTUNE_SPARQL_RW_HOST:8182/system -d "action=performDatabaseReset&token=$TOKEN"


