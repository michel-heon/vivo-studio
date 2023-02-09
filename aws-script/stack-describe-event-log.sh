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
cd $CF_TEMPLATE
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
stack-describe-event.sh $STACK_NAME| sort -r
while [ true ]
do
    sleep 3
    STACK_STATUS_TRACE="$(stack-describe-event.sh $STACK_NAME| sort -r | head -1 | tr -s '' '\t')"
    echo $STACK_STATUS_TRACE
    LOGICAL_ID=$(echo $STACK_STATUS_TRACE|tr -s ' ' | cut -f 2 -d ' ')
    STACK_STATUS=$(echo $STACK_STATUS_TRACE|tr -s ' ' | cut -f 3 -d ' ')
    [ "$STACK_STATUS" == "CREATE_COMPLETE" -a "$LOGICAL_ID" == "$STACK_NAME_ID" ] && echo "La création de $STACK_NAME_ID est complétée. En attente du retour d'AWS ..." && break
    [ "$STACK_STATUS" == "ROLLBACK_COMPLETE" -a "$LOGICAL_ID" == "$STACK_NAME_ID" ] && echo "ERREUR dans La création de $STACK_NAME_ID est complète. En attente du retour d'AWS ..." && break
done



