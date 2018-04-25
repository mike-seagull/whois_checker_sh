#!/usr/bin/env bash

DOMAIN_TO_CHECK=$1

WORKING_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
#source "${WORKING_DIR}/bash-logging/filehandler.sh" # logger
source "${WORKING_DIR}/bash-logging/streamhandler.sh" # logger

filename=$(basename "$0" | sed s/\.[^\.]*$//)
logfile="$WORKING_DIR/${filename}.log"

info "starting $0"
debug "DOMAIN_TO_CHECK = ${DOMAIN_TO_CHECK}"

RESP=$(whois ${DOMAIN_TO_CHECK} | grep "Registrant Name")
debug "RESP = \"${RESP}\""

if [ -z "$RESP" ]; then
	info "got nothing back. this domain is available. going to send a push message."
	#curl -s -o /dev/null -X POST --data "message=${DOMAIN_TO_CHECK} is available" http://www.michaelhollister.me/api/pushover 2>&1
	curl -s -o /dev/null -X POST --data "message=${DOMAIN_TO_CHECK} is available" http://home.michaelhollister.me/api/pushover 2>&1
else
	info "got something back. this domain is in use. going to do nothing."
fi

info "done"
