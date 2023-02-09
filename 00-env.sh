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
export AWS_SCRIPT=$ENV_SCRIPT_DIR/aws-script
export BASH_LIB=$ENV_SCRIPT_DIR/bash-lib
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
export NEPTUNE_INSTANCE_ADDRESS=$(aws neptune describe-db-instances --query 'DBInstances[].Endpoint.Address' --output=text)
export NEPTUNE_CLUSTER_RO_ADDRESS=$(aws neptune describe-db-clusters --query 'DBClusters[].ReaderEndpoint' --output=text)
export NEPTUNE_CLUSTER_RW_ADDRESS=$(aws neptune describe-db-clusters --query 'DBClusters[].Endpoint' --output=text)
export NEPTUNE_INSTANCE_ID=$(aws neptune describe-db-instances --query 'DBInstances[].DBInstanceIdentifier' --output=text)
export NEPTUNE_CLUSTER_ID=$(aws neptune describe-db-clusters --query 'DBClusters[].DBClusterIdentifier' --output=text)
export NEPTUNE_INSTANCE_URL="https://$NEPTUNE_INSTANCE_ADDRESS:8182"
export NEPTUNE_CLUSTER_RW_URL="https://$NEPTUNE_CLUSTER_RW_ADDRESS:8182"
export NEPTUNE_CLUSTER_RO_URL="https://$NEPTUNE_CLUSTER_RW_ADDRESS:8182"
export NEPTUNE_SPARQL_RW_URL="$NEPTUNE_CLUSTER_RW_ADDRESS:8182/sparql"

###################################################################
# Variables concernant le compte AWS
# Utilisateur applicatif du compte AWS: ex.:  
# vivo-dev-app pour le compte dev,  
# vivo-dev-app pour le compte pré-prod
# vivo-app pour le compte test
# vivo-app pour le compte demo
export AWS_USERNAME=vivo-app
export AWS_CLI_ACCOUNT=vivo-demo
export AWS_DEFAULT_PROFILE=vivo-demo
[ "$AWS_DEFAULT_PROFILE" == "expertises-app" ] && export CLE_SSH="vivo-uqam-aws-prod" 
[ "$AWS_DEFAULT_PROFILE" == "vivo-test" ]      && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-dev" ]       && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-demo" ]      && export CLE_SSH="vivo-uqam-aws-demo" 
###################################################################
export REGION="ca-central-1"
export ZONE="${REGION}a"
export ZONEB="${REGION}b"
# voir: https://docs.aws.amazon.com/fr_fr/AWSEC2/latest/WindowsGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair
export VPC_NAME="DirectConnect"
export aws_account_id=$(aws iam get-user --user-name $AWS_USERNAME  --query 'User.Arn' | cut -f 5 -d ':')


###################################################################
# Tomcat/Solr Services settings
export SOLR=$DEPLOY/solr/
export TOMCAT_VERSION="8.5.84"
export TOOLS_DIR=$TRANSLATOR_HOME/ldap-tools/tools

export PATH=$JAVA_HOME/bin\
:$SCRIPT\
:$AWS_SCRIPT\
:$BASH_LIB\
:$SOLR/bin\
:$TOMCAT_HOME/bin\
:$JENA_HOME\
:$JENA_HOME/bin\
:$TOOLS_DIR\
:$FUSEKI_HOME\
:$FUSEKI_HOME/bin\
:$PATH
alias log="tail -f $TOMCAT_HOME/logs/*"
alias cdgit="cd $GIT"
alias vienv="vi $ENV_SCRIPT_DIR/00-env.sh"

