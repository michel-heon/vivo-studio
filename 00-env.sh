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
export VS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
###################################################################
# VIVO-Studio settings
export GIT="$(cd $VS_SCRIPT_DIR/../ && pwd -P)"
export RESOURCES=$VS_SCRIPT_DIR/resources
export DEPLOY=$VS_SCRIPT_DIR/deploy
export SCRIPT=$VS_SCRIPT_DIR/script
export SCRIPT_AWS=$VS_SCRIPT_DIR/aws-script
export BASH_LIB=$VS_SCRIPT_DIR/bash-lib
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
export JAVA_HOME=$DEPLOY/amazon-corretto-11.0.18.10.1-linux-x64


###################################################################
# Variables concernant NEPTUNE
[ -z "$INST_NEPTUNE" ] && export INST_NEPTUNE=false;

if [ $INST_NEPTUNE = "true" ]; then
export NEPTUNE_INSTANCE_ADDRESS=$(aws neptune describe-db-instances --query 'DBInstances[].Endpoint.Address' --output=text)
export NEPTUNE_CLUSTER_RO_ADDRESS=$(aws neptune describe-db-clusters --query 'DBClusters[].ReaderEndpoint' --output=text)
export NEPTUNE_CLUSTER_RW_ADDRESS=$(aws neptune describe-db-clusters --query 'DBClusters[].Endpoint' --output=text)
export NEPTUNE_INSTANCE_ID=$(aws neptune describe-db-instances --query 'DBInstances[].DBInstanceIdentifier' --output=text)
export NEPTUNE_CLUSTER_ID=$(aws neptune describe-db-clusters --query 'DBClusters[].DBClusterIdentifier' --output=text)
export NEPTUNE_INSTANCE_URL="https://$NEPTUNE_INSTANCE_ADDRESS:8182"
export NEPTUNE_CLUSTER_RW_URL="https://$NEPTUNE_CLUSTER_RW_ADDRESS:8182"
export NEPTUNE_CLUSTER_RO_URL="https://$NEPTUNE_CLUSTER_RW_ADDRESS:8182"
export NEPTUNE_SPARQL_RW_URL="$NEPTUNE_CLUSTER_RW_ADDRESS:8182/sparql"
fi

###################################################################
# Variables concernant le compte AWS
# Utilisateur applicatif du compte AWS: ex.:  
# vivo-dev-app   pour le compte dev      avec le profile vivo-dev  
# vivo-dev-app   pour le compte pré-prod avec le profile vivo-pprod
# vivo-app       pour le compte test     avec le profile vivo-test
# vivo-app       pour le compte demo     avec le profile vivo-demo
# expertises-app pour le compte "prod"   avec le profile vivo-prod
[ -z "$AWS_USERNAME" ]        && export AWS_USERNAME=vivo-app 
[ -z "$AWS_DEFAULT_PROFILE" ] && export AWS_DEFAULT_PROFILE=vivo-demo
[ -z "$AWS_GROUP" ]           && export AWS_GROUP=vivo-grp
[ "$AWS_DEFAULT_PROFILE" == "expertises-app" ] && export CLE_SSH="vivo-uqam-aws-prod" 
[ "$AWS_DEFAULT_PROFILE" == "vivo-test" ]      && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-dev" ]       && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-demo" ]      && export CLE_SSH="vivo-uqam-aws-demo" 
[ "$AWS_DEFAULT_PROFILE" == "vivo-prod" ]      && export CLE_SSH="vivo-uqam-aws-demo" 
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
export TOMCAT_VERSION="8.5.85"
export TOOLS_DIR=$TRANSLATOR_HOME/ldap-tools/tools

export PATH=$JAVA_HOME/bin\
:$SCRIPT\
:$SCRIPT_AWS\
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
alias vienv="vi $VS_SCRIPT_DIR/00-env.sh"

