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
[ -z "$startDatetime" ] && startDatetime="2022-12-12 08:51:45 +0000"
[ -z "$endDatetime" ] && endDatetime="2022-12-12 08:53:13 +0000"

#startTime=$(date +"%y-%m-%d %H:%M:%S" --date="$startDatetime" +%s)
#endTime=$(date +"%y-%m-%d %H:%M:%S" --date="$endDatetime" +%s)
startTime=$(date --date="$startDatetime" +%s)
endTime=$(date --date="$endDatetime" +%s)

echo "|> startDatetime -> ${startDatetime}"
echo "|> endDatetime -> ${endDatetime}"
echo "|> startTime=$startTime"
echo "|> endTime=$endTime"

diffSeconds="$(($endTime - $startTime))"

echo "Diff in seconds: $diffSeconds"
echo "Diff in H:M:S (" $(echo "$diffSeconds/3600"|bc):$(echo "$diffSeconds/60"|bc):$(echo "$diffSeconds%60"|bc)")"
