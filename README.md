HEL Service Map Light
==========

![screenshot](https://raw.githubusercontent.com/terotic/hel-service-map-light/master/screenshot.png)

HEL Service Map Light is a map theme based on [OSM Bright][] and inspired by [Mapbox Light][]. 
The theme is used to display overlay data in geographic context.

Mapbox style
------------

For vector tile rendering of [OpenMapTiles][] imported OSM data, a [Mapbox Style][] re-enactment of the
original design is now included as `style.json` (Finnish) and `style_sv.json` (Swedish). It can be opened
and edited with [Maputnik][].

[OpenMapTiles]: https://github.com/openmaptiles/openmaptiles
[MapBox Style]: https://docs.mapbox.com/mapbox-gl-js/style-spec/
[Maputnik]: https://maputnik.github.io/
[Tileserver GL]: https://github.com/klokantech/tileserver-gl
[MapBox GL JS]: https://openmaptiles.org/docs/website/mapbox-gl-js/

To use the style on a server, just follow [OpenMapTiles][] and [Tileserver GL][] instructions. To use the
style on a web client, you may use [MapBox GL JS][] or any other JS library that supports Mapbox styles.

MapBox port by Riku Oja.

Original CartoCSS style
-----------------------

It is written in the [Carto][] styling language
and can be opened as a project in [TileMill][].

[Carto]: http://github.com/mapbox/carto/
[TileMill]: http://tilemill.com/
[Mapbox Light]: https://www.mapbox.com/maps/light-dark/
[OSM Bright]: https://github.com/mapbox/osm-bright
[Mapnik]: https://github.com/mapnik/mapnik

You will need to download these files and extract them in `shp` directory on your project root:

* http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
* http://data.openstreetmapdata.com/land-polygons-split-3857.zip
* http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip

See extended setup instructions on [OSM Bright][].

Theme style by Tero Tikkanen.
