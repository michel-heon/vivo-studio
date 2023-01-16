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
[ -z "$VIVO_CNAME" ] && export VIVO_CNAME=vivo-demo
[ -z "$VIVO_UQAM_RELEASE" ] && export VIVO_UQAM_RELEASE=sprint-demo

export NEPTUNE_CLUSTER_NAME="$VIVO_CNAME-${VIVO_UQAM_RELEASE}-neptune-cluster"
export NEPTUNE_INSTANCE_NAME="$VIVO_CNAME-${VIVO_UQAM_RELEASE}-neptune-instance"
export NEPTUNE_GROUP_NAME=$(echo "$VIVO_CNAME-${VIVO_UQAM_RELEASE}-neptune-group" | tr '[:upper:]' '[:lower:]')
export NEPTUNE_BUCKET_ROOT="$VIVO_CNAME-${VIVO_UQAM_RELEASE}-neptune-bucket"
export NEPTUNE_BUCKET_PARAM="$VIVO_CNAME-${VIVO_UQAM_RELEASE}-neptune-parameter"
export NEPTUNE_SPARQL_RW="$($NEP_SCRIPT_DIR/neptune-get-endpoint-rw.sh)"
export NEPTUNE_SPARQL_RO="$($NEP_SCRIPT_DIR/neptune-get-endpoint-ro.sh)"
export NEPTUNE_SPARQL_PORT=8182
export NEPTUNE_RW_URL="https://$NEPTUNE_SPARQL_RW:$NEPTUNE_SPARQL_PORT"
export NEPTUNE_RO_URL="https://$NEPTUNE_SPARQL_RO:$NEPTUNE_SPARQL_PORT"
echo curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' $NEPTUNE_RW_URL/system -d 'action=initiateDatabaseReset'
TOKEN=$(curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' $NEPTUNE_RW_URL/system -d 'action=initiateDatabaseReset' | jq -r '.payload.token')
echo "toke = ($TOKEN)"
sleep 2
echo $(curl -s -X POST -H 'Content-Type: application/x-www-form-urlencoded' $NEPTUNE_RW_URL/system -d "action=performDatabaseReset&token=$TOKEN" | jq -r)


