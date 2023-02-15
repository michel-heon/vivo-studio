#!/bin/bash

###################################################################
# Script Name   : sparql-get-expertises-from-fiche-prof.sh
# Description   : Extrait la liste des expertises associées à un prof
# Args          : Nom du fichier de la fiche de prof
# Author        : Michel Héon PhD
# Institution   : Université du Québec à Montréal
# Copyright     : Université du Québec à Montréal (c) 2022
# Email         : heon.michel@uqam.ca
###################################################################
export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd -P)"
source $SCRIPT_DIR/../conf/root-conf.sh
source $BASH_LIB/cleanup.sh


###################################################################
cat << EOF > $TMPDIR/cmd.sparql
query=prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#>  \
    prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> \
    prefix obo:   <http://purl.obolibrary.org/obo/> \
    prefix vivo:  <http://vivoweb.org/ontology/core#> \
    prefix xsd:     <http://www.w3.org/2001/XMLSchema#> \
    prefix owl:     <http://www.w3.org/2002/07/owl#> \
    prefix swrlb:   <http://www.w3.org/2003/11/swrlb#> \
    prefix rdp: <http://uqam.ca/data/rdp#> \
    prefix vitrob: <http://vitro.mannlib.cornell.edu/ns/vitro/1.7#> \
    prefix dc:      <http://purl.org/dc/elements/1.1/> \
    prefix pvs:     <http://vivoweb.org/ontology/provenance-support#> \
    prefix geo:     <http://aims.fao.org/aos/geopolitical.owl#> \
    prefix foaf:    <http://xmlns.com/foaf/0.1/> \
    prefix scires:  <http://vivoweb.org/ontology/scientific-research#>  \
    prefix scripps:  <http://vivo.scripps.edu/> \
    prefix dcterms:  <http://purl.org/dc/terms/> \
    prefix swrl:    <http://www.w3.org/2003/11/swrl#> \
    prefix vitro:   <http://vitro.mannlib.cornell.edu/ns/vitro/0.7#> \
    prefix event:   <http://purl.org/NET/c4dm/event.owl#> \
    prefix bibo:    <http://purl.org/ontology/bibo/> \
    prefix skos:    <http://www.w3.org/2004/02/skos/core#> \
    prefix vivo:    <http://vivo.library.cornell.edu/ns/0.1#> \
    prefix dcelem:  <http://purl.org/dc/elements/1.1/> \
    prefix ero:     <http://purl.obolibrary.org/obo/> \
    construct { ?s ?p ?o } \
    where { ?s ?p ?o } \
    limit 100
EOF
###################################################################
# à tester avec $TMPDIR/cmd.sparql  pour le --data-binary
cat  $TMPDIR/cmd.sparql
curl -H "Accept: text/turtle" -X POST --data-binary @$TMPDIR/cmd.sparql $NEPTUNE_INSTANCE_URL/sparql