#!/bin/bash

###################################################################
# Script Name   : sparql-get-expertises-from-fiche-prof.sh
# Description   : Extrait la liste des expertises associées à un prof
# Args          : Nom du fichier de la fiche de prof
# Author       	: Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2022
# Email         : heon.michel@uqam.ca
###################################################################
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $SCRIPT_DIR/00-env-ETL.sh
source $FUNC_LIB/cleanup.sh


###################################################################
cat << EOF > $TMPDIR/cmd.sparql 
query=prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#>  
    prefix obo:   <http://purl.obolibrary.org/obo/> 
    prefix vivo:  <http://vivoweb.org/ontology/core#> 
    prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
    prefix rdp: <http://uqam.ca/data/rdp#>
    select ?s ?p ?o where {?s ?p ?o} limit 10 
EOF
###################################################################
# à tester avec $TMPDIR/cmd.sparql  pour le --data-binary
curl -X POST --data-binary 'query=select ?s ?p ?o where {?s ?p ?o} limit 10'   $NEPTUNE_INSTANCE_URL/sparql



                  
                  