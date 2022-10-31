#!/usr/bin/env bash

set -euo pipefail

if [ $# != 2 ]; then
    echo "usage: $0 FILE1 FILE2"
    exit 1
fi

paste "$1" "$2" | tr '\t' '\n'
