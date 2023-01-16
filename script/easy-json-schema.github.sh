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
curl "https://easy-json-schema.github.io/" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:108.0) Gecko/20100101 Firefox/108.0" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" \
    -H "Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3" \
    -H "Accept-Encoding: gzip, deflate, br"  \
    -H "Connection: keep-alive"  \
    -H "Upgrade-Insecure-Requests: 1"  \
    -H "Sec-Fetch-Dest: document"  \
    -H "Sec-Fetch-Mode: navigate"  \
    -H "Sec-Fetch-Site: cross-site"  \
    -H "Sec-Fetch-User: ?1"  \
    -H "Sec-GPC: 1"  \
    -H "TE: trailers" \
    -d @/home/ubuntu/VIVO_UQAM_DEMO/00-GIT/vivo-studio/database/crilcq/acteurs/acteur_crilcq_2055.json
