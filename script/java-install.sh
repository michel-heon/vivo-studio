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
[ ! -f amazon-corretto-11-x64-linux-jdk.tar.gz ] && wget https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
tar -xzf amazon-corretto-11-x64-linux-jdk.tar.gz
mv amazon-corretto-11.0.17.8.1-linux-x64 JDK

