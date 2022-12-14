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
[ ! -d $VIVO_HOME/home/rdf ] && mkdir -p $VIVO_HOME/home/rdf
cp $RESOURCES/vivo-conf/runtime.properties $RESOURCES/vivo-conf/applicationSetup.n3 $VIVO_REPO/home/src/main/resources/config
cd $VIVO_UQAM_INSTALL
mvn -T2C clean install -DskipTests=true -s $RESOURCES/vivo-conf/settings.xml
