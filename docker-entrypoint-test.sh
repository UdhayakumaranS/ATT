#!/bin/sh

set -eu

start_time="$(date -u +%s)"

IFS=$'\n'
envlines=$(printenv | grep '_PORT\|_HOST' | grep -v '^NODE_' | cut -d '=' -f1)
echo $envlines
unset $envlines

finish_time="$(date -u +%s)"
elapsed="$((finish_time-$start_time))"

echo "Environment cleanup time: $elapsed seconds."