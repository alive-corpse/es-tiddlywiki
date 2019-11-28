#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env
CUID=`id -u`
CGID=`id -g`
cp .env_example .env
sed -i '/^CUID=/s/=.*$/='"$CUID"'/' .env
sed -i '/^CGID=/s/=.*$/='"$CGID"'/' .env
mkdir -p data/tw
docker-compose up -d --build
