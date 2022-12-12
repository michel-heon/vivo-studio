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
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $SCRIPT_DIR/../conf/root-conf.sh
[ -d $TOMCAT_HOME/webapps/$APP_NAME ] && rm -fr $TOMCAT_HOME/webapps/$APP_NAME
echo "VIVO dans ($TOMCAT_HOME/webapps/$APP_NAME) est supprimé"

