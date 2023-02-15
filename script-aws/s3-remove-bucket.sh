#!/bin/bash 

###################################################################
# Script Name   :
# Description   : Suppression d'un bucket S3 et de son contenu
# Args          : 
# Author        : Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2023
# Email         : heon.michel@uqam.ca
###################################################################

###################################################################
## entête
###################################################################
export LOC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $LOC_SCRIPT_DIR/../conf/vs-conf.sh
source $BASH_LIB/logging.sh
export verbosity=4 # niveau de verbosité de logger : 4=info
usage() { warn "Usage: $(basename $0) <bucket-name> " 1>&2; exit 1; }
[ -z "$1" ] && usage 

###################################################################
## Le noyau du script
###################################################################
info "Suppression du contenu du bucket $1"
aws s3 rm s3://$1 --recursive
set -x
info "Suppression du bucket $1"
aws s3 rb s3://$1 --force 
info "FIN de Suppression de $1"


