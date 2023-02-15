#!/bin/bash -u

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
cd $CF_TEMPLATE
BS=$(basename $1 .json)
STACK_NAME=$(basename $BS .yaml)
STACK_NAME_ID="$STACK_NAME-$aws_account_id"
function show_status() {
    STACK_STATUS=""
    while [ true ]
    do
        STACK_STATUS_TRACE="$(stack-describe-event.sh $STACK_NAME| sort -r | head -1)"
        LOGICAL_ID=$(echo $STACK_STATUS_TRACE|tr -s ' ' | cut -f 2 -d ' ')
        STACK_STATUS=$(echo $STACK_STATUS_TRACE|tr -s ' ' | cut -f 3 -d ' ')
        echo "$STACK_NAME : Le statut de la création du ($STACK_NAME_ID:$LOGICAL_ID) est: ($STACK_STATUS)"
        [ "$STACK_STATUS" == "CREATE_COMPLETE" -a "$LOGICAL_ID" == "$STACK_NAME_ID" ] && echo "La création de $STACK_NAME_ID est complétée. En attente du retour d'AWS ..." && break
        [ "$STACK_STATUS" == "ROLLBACK_COMPLETE" -a "$LOGICAL_ID" == "$STACK_NAME_ID" ] && echo "ERREUR dans La création de $STACK_NAME_ID est complète. En attente du retour d'AWS ..." && break
        sleep 5
    done
}
###################################################################
# Test d'existance du template en json ou yaml dans le répertoire $CF_TEMPLATE ou ./
if [ -f "$STACK_NAME.json" ]; then
    export STACK_NAME_FN=$STACK_NAME.json
else
    export STACK_NAME_FN=$STACK_NAME.yaml
fi
export FULL_STACK_PATH=""
[ -f "$CF_TEMPLATE/$STACK_NAME_FN" ] && export FULL_STACK_PATH=$(realpath "$CF_TEMPLATE/$STACK_NAME_FN")
[ -f "$STACK_NAME_FN" ] && export FULL_STACK_PATH=$(realpath "$STACK_NAME_FN") 
[ -z "$FULL_STACK_PATH" ] && echo "Le fichier ($STACK_NAME_FN) doit être dans le répertoire ($CF_TEMPLATE) ou './' " && exit -1
echo "###################################################################"
echo "###################################################################"
echo "### APPEL de $0"
echo "###################################################################"
echo "## STACK_NAME       =$STACK_NAME"
echo "## FULL_STACK_PATH  =$FULL_STACK_PATH"
echo "## STACK_NAME_FN    =$STACK_NAME_FN"
if [ "$(stack-status.sh $STACK_NAME)" == "CREATE_COMPLETE" ]
then
    echo "###################################################################"
    echo "###################################################################"
    echo "ATTENTION: La pile ($STACK_NAME) existe, aucune action n'est réalisée"
    echo "###################################################################"
    echo "###################################################################"
    exit 0
fi
DISABLE_ROLLBACK_OPT=""
DISABLE_ROLLBACK_OPT="--disable-rollback"

if [ -f "$STACK_NAME-parameters.json" ]; then
    echo "## STACK_NAME_PARAM =$STACK_NAME-parameters.json"
    echo "###################################################################"
    aws cloudformation create-stack --stack-name $STACK_NAME_ID $DISABLE_ROLLBACK_OPT --template-body file://$FULL_STACK_PATH --parameters file://$STACK_NAME-parameters.json --capabilities CAPABILITY_NAMED_IAM
    export EXIT_STATUS=$?
else
    echo "###################################################################"
    aws cloudformation create-stack --stack-name $STACK_NAME_ID $DISABLE_ROLLBACK_OPT --template-body file://$FULL_STACK_PATH --capabilities CAPABILITY_NAMED_IAM
    echo "aws cloudformation create-stack --stack-name $STACK_NAME_ID $DISABLE_ROLLBACK_OPT --template-body file://$FULL_STACK_PATH --capabilities CAPABILITY_NAMED_IAM"
    exit 0
    export EXIT_STATUS=$?
fi

[ $EXIT_STATUS != 0 ] && echo "$STACK_NAME_ID: ERREUR avec la valeur ($EXIT_STATUS)" && exit $EXIT_STATUS
############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":w" option; do
    case $option in
        w) # wait mode
            echo "Attente de la création de la pile ($STACK_NAME_ID)"
            show_status &
            aws cloudformation wait stack-create-complete --stack-name $STACK_NAME_ID
            exit ;;
    esac
done
wait
echo "Done! ($STACK_NAME_ID)"
echo "###################################################################"


