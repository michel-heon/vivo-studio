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
export BRC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
export PATH=$BRC_SCRIPT_DIR/script:$BRC_SCRIPT_DIR/conf-bin:$PATH:./
alias log="tail -f $TOMCAT_HOME/logs/*"
alias cdgit="cd $GIT"
alias vienv="vi $ENV_SCRIPT_DIR/00-env.sh"

