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
[ ! -f solr-8.11.2.tgz ] && wget https://downloads.apache.org/lucene/solr/8.11.2/solr-8.11.2.tgz
tar xzf solr-8.11.2.tgz
mv solr-8.11.2 solr
cp -rf $RESOURCES/solr/vivocore $DEPLOY/solr/server/solr/configsets/
