#!/bin/sh
cd /styles
./generate-styles.sh
chmod 550 generated-styles
cd /data
exec /usr/src/app/docker-entrypoint.sh
