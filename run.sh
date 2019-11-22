#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env
[ -d "./data" ] || mkdir -p data
docker run -d -v `pwd`/data:/tw/data -p 127.0.0.1:"$PORT":8080 --name $CTNAME $CTNAME

