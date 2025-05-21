#!/bin/sh
cd /generate-styles
mkdir generated-styles
./generate-styles.sh
mv ./generated-styles /data/generated-styles
cd /data
exec /usr/src/app/docker-entrypoint.sh
