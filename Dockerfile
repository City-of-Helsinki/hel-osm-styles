# Description: Dockerfile for the Helsinki tileserver-gl image
# Build: docker build -t helsinki/tileserver-gl:latest .
# Run: docker run --rm -it -v /local/data/mbtiles:/data/mbtiles -p 8080:8080 helsinki/tileserver-gl:latest

FROM container-registry.platta-net.hel.fi/devops/maptiler/tileserver-gl:v5.1.3

ADD config.tar.gz /data

# Setting group to 0 makes the environment similar to Openshift
# wrt. filesystem permissions. Openshift runs everything with group 0
USER node:0
