# Introduction

Prebuild TileServer GL image with built-in Helsinki-spesific styles.

# Build and Test

Build:

`docker build -t helsinki/tileserver-gl:latest .`

Run:

`docker run --rm -it -v /local/data/mbtiles:/data/mbtiles -p 8080:8080 helsinki/tileserver-gl:latest`
