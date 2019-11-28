#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env
docker-compose down 
docker rmi $CTNAME
