#!/usr/bin/env bash

##
## Simple logging mechanism for Bash
##
## Author: Michael Wayne Goodman <goodman.m.w@gmail.com>
## Thanks: Jul for the idea to add a datestring. See:
## http://www.goodmami.org/2011/07/simple-logging-in-bash-scripts/#comment-5854
## Thanks: @gffhcks for noting that inf() and debug() should be swapped,
##         and that critical() used $2 instead of $1
##
## License: Public domain; do as you wish
##

exec 3>&2 # logging stream (file descriptor 3) defaults to STDERR
verbosity=3 # default to show warnings
defaultlw=999
logwitdh=999
silent_lvl=0
crt_lvl=1
err_lvl=2
wrn_lvl=3
inf_lvl=4
dbg_lvl=5
set_debug(){
	case $- in
		*x*) 
			set +x
			export DEBUG
			;;
	esac
}
notify() { set_debug && [[ $# -lt 2 ]]   || logwitdh=$2 ; log $silent_lvl "NOTE: $1"; } # Always prints
critical() { set_debug && [[ $# -lt 2 ]] || logwitdh=$2 ; log $crt_lvl "CRITICAL: $1"; }
error() { [[ $# -lt 2 ]]    || logwitdh=$2 ; log $err_lvl "ERROR: $1"; }
warn() { [[ $# -lt 2 ]]     || logwitdh=$2 ; log $wrn_lvl "WARNING: $1"; }
inf() { set_debug && [[ $# -lt 2 ]]      || logwitdh=$2 ; log $inf_lvl "INFO: $1";  } # "info" is already a command
info() { set_debug && [[ $# -lt 2 ]]     || logwitdh=$2 ; log $inf_lvl "INFO: $1";  } # "info" is already a command
debug() { [[ $# -lt 2 ]]    || logwitdh=$2 ; log $dbg_lvl "DEBUG: $1"; }
log() {
    if [ $verbosity -ge $1 ]; then
        datestring=`date +'%Y-%m-%d %H:%M:%S'`
        # Expand escaped characters, wrap at 70 chars, indent wrapped lines
#        echo -e "$datestring $2" | fold -w70 -s | sed '2~1s/^/  /' >&3
        echo -e "$datestring $2" | fold -w$logwitdh -s | sed '2~1s/^/  /' >&3
        logwitdh=$defaultlw
    fi
    [ -z DEBUG ] && set -x
}
