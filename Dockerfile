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
      curl && \
    apt-get -y --purge autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*      

USER node:node

ADD config.tar.gz /data

# Copy the download script to the container
ADD --chmod=755 scripts /scripts

# Setting group to 0 makes the environment similar to Openshift
# wrt. filesystem permissions. Openshift runs everything with group 0
USER node:0
