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
export ENV_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
###################################################################
# VIVO-Studio settings

export GIT="$(cd $ENV_SCRIPT_DIR/../ && pwd -P)"
export RESOURCES=$ENV_SCRIPT_DIR/resources
export DEPLOY=$ENV_SCRIPT_DIR/deploy
export SCRIPT=$ENV_SCRIPT_DIR/script
export VIVO_REPO=$GIT/VIVO
export VIVO_UQAM_INSTALL=$GIT/vivo-uqam-installer
export VIVO_DIST_RELEASE=1.13.1-SNAPSHOT
###################################################################
# VIVO settings
export APP_NAME=vivo
export TOMCAT_HOME=$DEPLOY/tomcat
export VIVO_HOME=$DEPLOY/vivo
export VIVO_THEME=uqam

###################################################################
# Semantic Web Services settings
export TRANSLATOR_REPO=$GIT/data-format-translator
export TRANSLATOR_HOME=$DEPLOY/translator
export JENA_HOME=$TRANSLATOR_HOME
export FUSEKI_HOME=$DEPLOY/fuseki
export FUSEKI_BASE=$FUSEKI_HOME/base
export JAVA_HOME=$DEPLOY/JDK

#export JRE_HOME=$JAVA_HOME/jre

###################################################################
# Variables concernant NEPTUNE
export NEPTUNE_SPARQL_RW_HOST="vivo-reader-cfdev-dev-neptune-cluster.cluster-c2o1sdzzfasi.ca-central-1.neptune.amazonaws.com"
export NEPTUNE_SPARQL_RW_URL="https://$NEPTUNE_SPARQL_RW_HOST:8182/sparql"

###################################################################
# Tomcat/Solr Services settings
export SOLR=$DEPLOY/solr/
export TOMCAT_VERSION="8.5.84"
export TOOLS_DIR=$TRANSLATOR_HOME/ldap-tools/tools

export PATH=$SCRIPT:$JAVA_HOME/bin:$SOLR/bin:$TOMCAT_HOME/bin:$JENA_HOME:$JENA_HOME/bin:$TOOLS_DIR:$FUSEKI_HOME:$FUSEKI_HOME/bin:$PATH
alias log="tail -f $TOMCAT_HOME/logs/*"
alias cdgit="cd $GIT"
alias vienv="vi $ENV_SCRIPT_DIR/00-env.sh"

