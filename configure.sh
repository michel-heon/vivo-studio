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
export VS_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $VS_HOME/00-env.sh
env -i bash --norc --noprofile -c "source $VS_HOME/00-env.sh ; printenv | grep -v 'printenv' | sort | sed 's/^/export /'" > $VS_HOME/conf/root-conf.sh
