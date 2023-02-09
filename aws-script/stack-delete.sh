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
BS=$(basename $1 .json)
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
function show_status() {
    STACK_STATUS=""
    while [ true ]
    do
        STACK_STATUS="$(stack-describe-event.sh $STACK_NAME| sort -r | head -1)"
        ! [ -n "$STACK_STATUS" ] && break
        echo "Le statut de la suppression est: ($STACK_STATUS)"
        sleep 3
    done
}
echo "Lancement de la suppression de la pile ($STACK_NAME_ID)"
aws cloudformation delete-stack --stack-name $STACK_NAME_ID
echo "Attente de la suppression de la pile ($STACK_NAME_ID)"
show_status &
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME_ID
wait
echo "Done! suppression de ($STACK_NAME_ID)"

