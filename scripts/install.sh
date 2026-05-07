#!/bin/bash
set -e

if [ $# -eq 0 ]; then
    echo "No mods provided to install."
    exit 0
fi

echo "Installing mods: $@"
cd /world
npm install "$@"