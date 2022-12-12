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
cd $DEPLOY
FUSEKI=apache-jena-fuseki-3.17.0
[ ! -f $FUSEKI.tar.gz ] && wget https://archive.apache.org/dist/jena/binaries/$FUSEKI.tar.gz
[ ! -d fuseki ] && mkdir fuseki
tar xzvf $FUSEKI.tar.gz --directory ./fuseki --strip-components=1


