#!/bin/bash -u

###################################################################
# Script Name   :
# Description   :
# Args          : 
# Author        : Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2023
# Email         : heon.michel@uqam.ca
###################################################################
export LOC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $LOC_SCRIPT_DIR/../conf/vs-conf.sh

###################################################################
# Spécification de l'usage
usage() { echo "Usage: $0 <policy-arn> " 1>&2; exit 1; }
[ -z "$1" ] && usage 


###################################################################
# Coeur de la commande
aws iam  detach-group-policy --policy-arn $1 --group-name $AWS_GROUP 
