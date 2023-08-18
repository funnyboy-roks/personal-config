#!/bin/bash
# Usage ./paper-latest <version>
# Requires `wget` (not `jq`, but relies on my API working :P)

# Text Colors >:D
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'

OUTPUT=$1
if [ -z "$1" ]; then
    OUTPUT='paper.jar'
fi

if [ -z "$2" ]; then
    wget -O "$OUTPUT" 'https://api.funnyboyroks.com/paper/latest'
else
    wget -O "$OUTPUT" "https://api.funnyboyroks.com/paper/$2"
fi

echo "${GREEN}Downloaded latest Paper version to ${YELLOW} ${OUTPUT}"
