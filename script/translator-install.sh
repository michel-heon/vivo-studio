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
export TR_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $TR_SCRIPT_DIR/../conf/root-conf.sh
export TRANSLATOR_HOME=$DEPLOY/translator
cd $TRANSLATOR_REPO
./install-translator.sh

