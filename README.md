# Introduction

Prebuild TileServer GL image with built-in Helsinki OSM styles.

# Build and Test locally

Modify Dockerfile to use the dockerhub image instead of platta image.

Build:

`docker build -t helsinki/tileserver-gl:latest .`

## Run with platta hosted mbtiles

`docker run --rm -it -e SOURCES_OPENMAPTILES_URL=https://helsinki-maptiles.dev.hel.ninja/data/helsinki.json -p 8080:8080 helsinki/tileserver-gl:latest`

## Run with local mbtiles

If you have `/local/data/mbtiles/helsinki.mbtiles` then

`docker run --rm -it -v /local/data/mbtiles:/data/mbtiles -p 8080:8080 helsinki/tileserver-gl:latest`

`SOURCES_OPENMAPTILES_URL` defaults to `mbtiles://helsinki.mbtiles`. Override as needed using `-e`


## Contributing

The project uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

[`pre-commit`](https://pre-commit.com/) can be used to install and
run all the formatting tools as git hooks automatically before a
commit.


## HEL Service Map Bright

![screenshot](https://raw.githubusercontent.com/city-of-helsinki/hel-osm-bright/master/screenshot.png)

HEL Service Map Bright is a map theme based on [OSM Bright][].
The theme is used to display overlay data in geographic context.

### Mapbox style

For vector tile rendering of [OpenMapTiles][] imported OSM data, a [Mapbox Style][] re-enactment of the
original design is now included as `templates/hel-osm-bright.json`. The generated style can be opened
and edited with [Maputnik][].

[OpenMapTiles]: https://github.com/openmaptiles/openmaptiles
[MapBox Style]: https://docs.mapbox.com/mapbox-gl-js/style-spec/
[Maputnik]: https://maputnik.github.io/
[Tileserver GL]: https://github.com/klokantech/tileserver-gl
[MapBox GL JS]: https://openmaptiles.org/docs/website/mapbox-gl-js/

To use the style on a server, just follow [OpenMapTiles][] and [Tileserver GL][] instructions. To use the
style on a web client, you may use [MapBox GL JS][] or any other JS library that supports Mapbox styles.

MapBox port by Riku Oja.

Based on CartoCSS theme style by Kalle Järvenpää.


## HEL Service Map Light

![screenshot](https://raw.githubusercontent.com/city-of-helsinki/hel-service-map-light/master/screenshot.png)

HEL Service Map Light is a map theme based on [OSM Bright][] and inspired by [Mapbox Light][].
The theme is used to display overlay data in geographic context.

MapBox port by Riku Oja.

Based on CartoCSS theme style theme style by Tero Tikkanen.

## High contrast

![screenshot](https://raw.githubusercontent.com/City-of-Turku/high-contrast-map-layer/refs/heads/master/screenshot-2.png)

A high contrast map background layer
