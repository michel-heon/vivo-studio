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
aws rds describe-orderable-db-instance-options --engine neptune --query 'OrderableDBInstanceOptions[].DBInstanceClass' --output=text | tr -s '\t' '\n' | sort -u
