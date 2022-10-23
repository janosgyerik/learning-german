#!/usr/bin/env bash

set -euo pipefail

paste "$1" "$2" | tr '\t' '\n'
