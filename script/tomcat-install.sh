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
source $SCRIPT_DIR/../conf/vs-conf.sh
cd $DEPLOY
[ ! -f apache-tomcat-${TOMCAT_VERSION}.zip ] && wget https://dlcdn.apache.org/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip
unzip apache-tomcat-*.zip
mv apache-tomcat-${TOMCAT_VERSION} $DEPLOY/tomcat/
cat << EOF > $DEPLOY/tomcat/conf/tomcat-users.xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
version="1.0">
<user username="admin" password="admin" roles="manager-gui"/>
<user username="robot" password="admin" roles="manager-script"/>
<role rolename="tomcat"/>
<user username="tomcat" password="admin1234." roles="tomcat"/>
</tomcat-users>
EOF
cd $DEPLOY/tomcat/
find . -name '*.sh' -exec chmod +x {} \;
