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
export LOC_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
export DC_VPC_ID=$(aws ssm get-parameter --name DC_VPC_ID --query 'Parameter.Value' --output=text)
export DC_SUBNET_PUBLIC_ID_1=$(aws ssm get-parameter --name DC_SUBNET_PUBLIC_ID_1 --query 'Parameter.Value' --output=text)
export DC_SUBNET_PUBLIC_ID_2=$(aws ssm get-parameter --name DC_SUBNET_PUBLIC_ID_2 --query 'Parameter.Value' --output=text)
export DC_SUBNET_PRIVATE_ID_1=$(aws ssm get-parameter --name DC_SUBNET_PRIVATE_ID_1 --query 'Parameter.Value' --output=text)
export DC_SUBNET_PRIVATE_ID_2=$(aws ssm get-parameter --name DC_SUBNET_PRIVATE_ID_2 --query 'Parameter.Value' --output=text)
export DC_INTERNET_GATEWAY_ID=$(aws ssm get-parameter --name DC_INTERNET_GATEWAY_ID --query 'Parameter.Value' --output=text)
export DC_DEFAULT_SECURITY_GROUP_ID=$(aws ssm get-parameter --name DC_DEFAULT_SECURITY_GROUP_ID --query 'Parameter.Value' --output=text)
export DC_SERVICE_ROLE=$(aws ssm get-parameter --name DC_SERVICE_ROLE --query 'Parameter.Value' --output=text)
export DC_DEFAULT_ROUTE_TABLE_ID=$(aws ssm get-parameter --name DC_DEFAULT_ROUTE_TABLE_ID --query 'Parameter.Value' --output=text)


