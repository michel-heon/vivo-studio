#!/bin/bash -u

###################################################################
# Script Name   :
# Description   :
# Args          : 
# Author       	: Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2021
# Email         : heon.michel@uqam.ca
###################################################################
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $SCRIPT_DIR/../conf/root-conf.sh
LOW_CLASS=db.t3.medium
set -x
aws neptune modify-db-instance \
  --db-instance-identifier $NEPTUNE_INSTANCE_ID \
  --db-instance-class db.r6g.16xlarge \
  --apply-immediately
  
  
  

