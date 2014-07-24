#!/bin/bash

# Check required arguments.
if (( $# < 2 ))
then
	echo >&2 "Usage: $0 <node> <ec2-command> [<arguments>]"
	exit 2
fi

# Fail fast.
set -eu


NODE=$1; shift
COMMAND=$1; shift;


## Export neeeded environment variables

export JAVA_HOME=$RD_CONFIG_JAVA_HOME
export EC2_BASE=$RD_CONFIG_EC2_BASE
export EC2_HOME=$EC2_BASE
export AWS_ACCESS_KEY=$RD_CONFIG_AWS_ACCESS_KEY
export AWS_SECRET_KEY=$RD_CONFIG_AWS_SECRET_KEY

if [[ ! -e $EC2_BASE/bin/${COMMAND} ]]
then
	echo >&2 "ERROR: Plugin could access ec2-tools executable: $EC2_BASE/bin/${COMMAND}"
	exit 3
fi

# Configure the command with the credentials.
CLOPS=(--url $RD_CONFIG_EC2_URL)

# Configure the region
CLOPS=(${CLOPS[*]} --region $RD_CONFIG_REGION)

# Turn on verbose if the user specified it.
if [[ "true" == ${RD_CONFIG_VERBOSE} ]]
then CLOPS=(${CLOPS[*]} -verbose)
fi 

# Execute the command!
$EC2_BASE/bin/${COMMAND} ${CLOPS[*]} ${@}

exit $?
