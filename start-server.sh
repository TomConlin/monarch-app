#!/bin/sh

# ./start-server.sh [ENVNAME]
#
# ENVNAME: dev, stage, production (default is 'dev')
# Optional environment variables:
#	PORT (defaults to 8080)
#

RUNENV=$1
if [ ! $RUNENV ]; then
	RUNENV=dev
fi

PATH_TO_ME=`which $0`
cd `dirname $PATH_TO_ME`

if [ $PORT ]
  then
   MARGS="--port $PORT"
  else
   MARGS="--port 8080"
fi

export NODE_PATH=./lib/monarch
node lib/monarch/web/webapp_launcher.js $MARGS $RUNENV
