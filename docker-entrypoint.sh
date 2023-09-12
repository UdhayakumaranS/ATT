#!/bin/sh

set -eu

start_time="$(date -u +%s)"

IFS=$'\n'
envlines=$(printenv | grep '_PORT\|_HOST' | grep -v '^NODE_' | cut -d '=' -f1)
unset $envlines

finish_time="$(date -u +%s)"
elapsed="$((finish_time-$start_time))"

echo "Environment cleanup time: $elapsed seconds."

cd /opt/att/app

if [ "$NODE_REDIS_TLS_ENABLED" = "true" ]; then
  /usr/bin/stunnel /opt/att/etc/stunnel/conf/stunnel.conf
fi

if [ "$NODE_PM2_ENABLED" = "true" ]; then
  exec ./node_modules/.bin/pm2-runtime start ./pm2.json
else
  exec node --max-http-header-size=200000 ./src/server/server.js
fi