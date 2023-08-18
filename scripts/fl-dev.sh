#!/bin/sh
# Usage: fl-dev.sh [<artifact-name>]
#
# What I run for working on FarLands -- this restarts our dev server, so it's only able to be used by very few people :P

set -e

echo 'Building...'
mvn package -Dmaven.javadoc.skip=true

echo 'Uploading jar...'
rsync -vazPtu "target/${1-FarLands}.jar" fl:dev-server/plugins/FarLands/cache

echo 'Sending dev restart request...'
ssh fl 'screen -S mc-dev -p 0 -X stuff "shutdown restart now\n"'
