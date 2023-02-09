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
function show_status() {
    STACK_STATUS=""
    while ! [ "$STACK_STATUS)" == "CREATE_COMPLETE" ]
    do
        STACK_STATUS="$(stack-status.sh $STACK_NAME)"
        [ -n "STACK_STATUS" ] && break;
        echo "$STACK_NAME : Le statut de la création est: ($STACK_STATUS)"
        sleep 3
    done
}
BS=$(basename $1 .json)
cd $CF_TEMPLATE
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
echo "Suivre le progression des événements pour ($STACK_NAME_ID)"
show_status
wait
echo "Done! ($STACK_NAME_ID) est crée"


