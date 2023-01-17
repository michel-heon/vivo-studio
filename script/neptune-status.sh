#!/bin/bash -u

###################################################################
# Script Name   :
# Description   :
# Args          : 
# Author       	: Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2022
# Email         : heon.michel@uqam.ca
###################################################################
export LOG_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $LOG_SCRIPT_DIR/../conf/root-conf.sh
source $BASH_LIB/logging.sh
inf "STATUS=$(aws neptune describe-db-instances --db-instance-identifier $NEPTUNE_INSTANCE_ID --query 'DBInstances[].DBInstanceStatus' --output=text)" 9999
curl -s -G "$NEPTUNE_INSTANCE_URL/status" | jq .



exit 0

nep_status=$(aws neptune describe-db-clusters \
    --db-cluster-identifier $NEPTUNE_CLUSTER_NAME \
    --query 'DBClusters[].Status' --output=text)
echo "Status of $NEPTUNE_CLUSTER_NAME = $nep_status"
nep_status_inst=$(aws neptune describe-db-instances \
    --db-instance-identifier $NEPTUNE_INSTANCE_NAME \
    --query 'DBInstances[].DBInstanceStatus' --output=text)
echo "Status of $NEPTUNE_CLUSTER_NAME-instance = $nep_status_inst"

echo $NEPTUNE_ENDPOINT_URL
