#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env
docker build -t "$CTNAME:latest" .

