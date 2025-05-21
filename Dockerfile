# Description: Dockerfile for the Helsinki tileserver-gl image
# Build: docker build -t helsinki/tileserver-gl:latest .
# Run: docker run --rm -it -v /local/data/mbtiles:/data/mbtiles -p 8080:8080 helsinki/tileserver-gl:latest

# local development base image path
# FROM maptiler/tileserver-gl:v5.1.3
FROM container-registry.platta-net.hel.fi/devops/maptiler/tileserver-gl:v5.1.3

USER root:root

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      curl gettext-base && \
    apt-get -y --purge autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV SOURCES_OPENMAPTILES_URL "mbtiles://helsinki.mbtiles"
ENV GLYPHS_URL "{fontstack}/{range}.pbf"

RUN mkdir /generate-styles && chown node:0 /generate-styles
ADD docker-entrypoint.sh /generate-styles
ADD generate-styles.sh /generate-styles
ADD templates /generate-styles/templates
ADD fonts /data/fonts
ADD mbtiles /data/mbtiles
ADD sprites /data/sprites
ADD config /data


USER node:node

# Setting group to 0 makes the environment similar to Openshift
# wrt. filesystem permissions. Openshift runs everything with group 0
USER node:0

ENTRYPOINT ["/generate-styles/docker-entrypoint.sh"]
