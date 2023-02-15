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
export SCRIPT_AWS=$VS_SCRIPT_DIR/script-aws
export BASH_LIB=$VS_SCRIPT_DIR/bash-lib
[ -z "$VIVO_REPO" ]           && export VIVO_REPO=$GIT/VIVO
[ -z "$VIVO_INSTALLER_HOME" ] && export VIVO_INSTALLER_HOME=$GIT/vivo-uqam-installer
[ -z "$VIVO_DIST_RELEASE" ]   && export VIVO_DIST_RELEASE=1.13.1-SNAPSHOT
###################################################################
# VIVO settings
[ -z "$APP_NAME" ]            && export APP_NAME=vivo
[ -z "$TOMCAT_HOME" ]         && export TOMCAT_HOME=$DEPLOY/tomcat
[ -z "$EBS_HOME" ]            && export EBS_HOME=$DEPLOY/ebs
[ -z "$VIVO_HOME" ]           && export VIVO_HOME=$DEPLOY/vivo
[ -z "$VIVO_THEME" ]          && export VIVO_THEME=uqam
[ -z "$VIVO_PKG" ]            && export VIVO_PKG=${GIT}/VIVO
[ -z "$VITRO_PKG" ]           && export VITRO_PKG=${GIT}/Vitro
[ -z "$SAMPLE_PKG" ]          && export SAMPLE_PKG=${GIT}/sample-data
[ -z "$VIVO_CNAME_EBS_ENV" ]  && export VIVO_CNAME_EBS_ENV=${VIVO_CNAME}-env  # Nom de l’environnement de déploiement

###################################################################
# Configuration de VIVO runtime.properties
#
# EXEMPLE de configuration du fichier vivo-uqam-passwd.properties
# cat ~/.aws/vivo-uqam-passwd.properties
# vivo.user=VOTRE-COMPTE-UTILSATEUR
# vivo.password=VOTRE-MOT-DE-PASSE
[ -z "$USER_PROPERTIES" ] && export USER_PROPERTIES=~/.aws/vivo-uqam-passwd.properties
[ -f "$USER_PROPERTIES" ] && export ROOT_USER_EMAIL=$(grep vivo.user $USER_PROPERTIES | cut -d'=' -f2 )   # Compte administrateur déployé sur l'instance VIVO
[ -f "$USER_PROPERTIES" ] && export ROOT_USER_PASSWD=$(grep vivo.password $USER_PROPERTIES | cut -d'=' -f2 )  # Mot de passe de l'administrateur
[ -z "$VIVO_DEFAULT_NS" ]  && export VIVO_DEFAULT_NS=http://vivo.uqam.ca/individual/
[ -z "$SOLR_URL" ]  && export SOLR_URL=http://localhost:8983/solr/vivocore

###################################################################
# Semantic Web Services settings
export TRANSLATOR_REPO=$GIT/data-format-translator
export TRANSLATOR_HOME=$DEPLOY/translator
export JENA_HOME=$TRANSLATOR_HOME
export FUSEKI_HOME=$DEPLOY/fuseki
export FUSEKI_BASE=$FUSEKI_HOME/base
export JAVA_HOME=$DEPLOY/amazon-corretto-11.0.18.10.1-linux-x64

[ -z "$INSTALL_SOLR_EBS" ] && export INSTALL_SOLR_EBS=false;
[ -z "$INSTALL_FUSEKI" ]   && export INSTALL_FUSEKI=false;

###################################################################
# Configurations associées à AWS
[ -z "$CF_TEMPLATE" ] && export CF_TEMPLATE=$(realpath $VS_SCRIPT_DIR/templates)

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
[ "$AWS_DEFAULT_PROFILE" == "expertises-app" ] && [ -z "$CLE_SSH" ] && export CLE_SSH="vivo-uqam-aws-prod" 
[ "$AWS_DEFAULT_PROFILE" == "vivo-test" ]      && [ -z "$CLE_SSH" ] && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-dev" ]       && [ -z "$CLE_SSH" ] && export CLE_SSH="Cle-VIVO-Demo"
[ "$AWS_DEFAULT_PROFILE" == "vivo-demo" ]      && [ -z "$CLE_SSH" ] && export CLE_SSH="vivo-uqam-aws-demo" 
[ "$AWS_DEFAULT_PROFILE" == "vivo-prod" ]      && [ -z "$CLE_SSH" ] && export CLE_SSH="vivo-uqam-aws-demo" 
[ -z "$CLE_SSH" ] && export CLE_SSH="vivo-uqam-cle-ssh"
###################################################################
export REGION="ca-central-1"
export ZONE="${REGION}a"
export ZONEB="${REGION}b"
# voir: https://docs.aws.amazon.com/fr_fr/AWSEC2/latest/WindowsGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair
export VPC_NAME="DirectConnect"
export aws_account_id=$(aws iam get-user --user-name $AWS_USERNAME  --query 'User.Arn' | cut -f 5 -d ':')


###################################################################
# Tomcat/Solr Services settings
export SOLR=$DEPLOY/solr
export TOMCAT_VERSION=\""8.5.85"\"
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
:$TRANSLATOR_HOME/bin\
:$PATH
alias log="tail -f $TOMCAT_HOME/logs/*"
alias cdgit="cd $GIT"
alias vienv="vi $VS_SCRIPT_DIR/00-env.sh"

