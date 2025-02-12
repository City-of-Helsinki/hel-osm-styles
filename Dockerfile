# Description: Dockerfile for the Helsinki tileserver-gl image
# Build: docker build -t helsinki/tileserver-gl:latest .
# Run: docker run --rm -it -v /local/data/mbtiles:/data/mbtiles -p 8080:8080 helsinki/tileserver-gl:latest

FROM maptiler/tileserver-gl:v5.1.3

COPY config.tar.gz .

RUN tar xzf config.tar.gz && \
    rm config.tar.gz

USER node:0
