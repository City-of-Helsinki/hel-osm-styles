# Description: Dockerfile for the Helsinki tileserver-gl image
# See README.md for build and running instructions

ARG BUILDER_REGISTRY=docker.io
FROM ${BUILDER_REGISTRY}/maptiler/tileserver-gl:v5.4.0
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

COPY generate-styles.sh /styles/
COPY templates /styles/templates
COPY fonts /data/fonts
COPY mbtiles /data/mbtiles
COPY sprites /data/sprites
COPY config /data


USER node:node

# Setting group to 0 makes the environment similar to Openshift
# wrt. filesystem permissions. Openshift runs everything with group 0
USER node:0
