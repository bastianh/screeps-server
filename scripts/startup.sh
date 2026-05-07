#!/bin/bash
set -e

ARGLIST=()

# Required variables
if [ -z "$STEAM_API_KEY" ]; then
    echo "Error: Missing STEAM_API_KEY! The server will not run without it."
    exit 1
fi

# Check for docker environment variables
if [ -n "$SCREEPS_PORT" ]; then
    ARGLIST+=("--port" "$SCREEPS_PORT")
fi

if [ -n "$SCREEPS_HOST" ]; then
    ARGLIST+=("--host" "$SCREEPS_HOST")
fi

if [ -n "$SCREEPS_PASS" ]; then
    ARGLIST+=("--password" "$SCREEPS_PASS")
fi

if [ -n "$SCREEPS_CLI_PORT" ]; then
    ARGLIST+=("--cli_port" "$SCREEPS_CLI_PORT")
fi

if [ -n "$SCREEPS_CLI_HOST" ]; then
    ARGLIST+=("--cli_host" "$SCREEPS_CLI_HOST")
fi

if [ ! -f "/world/.inited" ]; then
    echo "Initializing Screeps world..."
    if [ -f "/world/.screepsrc-temp" ]; then
        echo "Applying .screepsrc template..."
        mv /world/.screepsrc-temp /world/.screepsrc
        sed -i "s/^steam_api_key =.*/steam_api_key = ${STEAM_API_KEY}/" /world/.screepsrc
    fi
    if [ -f "/world/mods.json-temp" ]; then
        mv /world/mods.json-temp /world/mods.json
    fi
    touch /world/.inited
fi

echo "Starting Screeps server..."
# Finally start the server
npx screeps start --steam_api_key "$STEAM_API_KEY" "${ARGLIST[@]}"
