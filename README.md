This repository hosts various map styles used by Helsinki



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
