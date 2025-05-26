# Description: Dockerfile for the Helsinki tileserver-gl image
# See README.md for build and running instructions

ARG BUILDER_REGISTRY=docker.io
FROM ${BUILDER_REGISTRY}/maptiler/tileserver-gl:v5.1.3
USER root:root

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      curl gettext-base && \
    apt-get -y --purge autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# These ENVs are used by the init container that generates the styles in openshift
ENV SOURCES_OPENMAPTILES_URL="mbtiles://helsinki.mbtiles"
ENV GLYPHS_URL="{fontstack}/{range}.pbf"

ADD generate-styles.sh /styles/
ADD templates /styles/templates
ADD fonts /data/fonts
ADD mbtiles /data/mbtiles
ADD sprites /data/sprites
ADD config /data


USER node:node

# Setting group to 0 makes the environment similar to Openshift
# wrt. filesystem permissions. Openshift runs everything with group 0
USER node:0
