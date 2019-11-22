#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env
docker logs --tail 50 -f $CTNAME
