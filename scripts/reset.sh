#!/bin/sh

CLI_HOST=${SCREEPS_CLI_HOST:-127.0.0.1}
CLI_PORT=${SCREEPS_CLI_PORT:-21026}

echo "Resetting all data via CLI at $CLI_HOST:$CLI_PORT..."
echo "system.resetAllData()" | nc -w 3 "$CLI_HOST" "$CLI_PORT" > /dev/null