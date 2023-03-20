#!/bin/sh
#
# init.sh
#
#   Run it in the root directory of your project
#

ECHO=/bin/echo

ENV_FILE=./.env
HOST_GID=`id -g`
HOST_UID=`id -u`
DEV_USER_NAME=`whoami`

if [ $HOST_GID -lt 501 ]; then
    HOST_GID=501
fi

$ECHO "HOST_UID=${HOST_UID}" >> $ENV_FILE
$ECHO "HOST_GID=${HOST_GID}" >> $ENV_FILE
$ECHO "DEV_USER_NAME=${DEV_USER_NAME}" >> $ENV_FILE

$ECHO "creating ${ENV_FILE} done."
