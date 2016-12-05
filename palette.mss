/* ****************************************************************** */
/* HEL SERVICE MAP LIGHT based on OSM BRIGHT for Imposm                                              */
/* ****************************************************************** */

/* Modified for the City of Helsinki by Tero Tikkanen */

/* For basic style customization you can simply edit the colors and
 * fonts defined in this file. For more detailed / advanced
 * adjustments explore the other files.
 *
 * GENERAL NOTES
 *
 * There is a slight performance cost in rendering line-caps.  An
 * effort has been made to restrict line-cap definitions to styles
 * where the results will be visible (lines at least 2 pixels thick).
 */

/* ================================================================== */
/* FONTS
/* ================================================================== */

/* directory to load fonts from in addition to the system directories */
Map { font-directory: url(./fonts); }

/* set up font sets for various weights and styles */
@sans_lt:       "Lato Light";

@sans_lt_italic:"Lato Light Italic";

@sans:          "Lato Regular";

@sans_italic:   "Lato Italic";

@sans_bold:  "Lato Bold";

@sans_bold_italic:  "Lato Bold Italic";

/* Some fonts are larger or smaller than others. Use this variable to
   globally increase or decrease the font sizes. */
/* Note this is only implemented for certain things so far */
@text_adjust: 0;

/* ================================================================== */
/* LANDUSE & LANDCOVER COLORS
/* ================================================================== */

@land:              #f2f2f2;
@water:             #c2d3d4;
@grass:             #e5e9e6;
@beach:             darken(@land, 5%);
@park:              @grass;
@cemetery:          @grass;
@wooded:            darken(@grass, 5%);
@agriculture:       @grass;

@building:          #e6e6e6;
@hospital:          @land;
@school:            @land;
@sports:            darken(@grass, 3%);

@residential:       @land;
@commercial:        @land;
@industrial:        @land;
@parking:           #fafafa;

/* ================================================================== */
/* ROAD COLORS
/* ================================================================== */

/* For each class of road there are three color variables:
 * - line: for lower zoomlevels when the road is represented by a
 *         single solid line.
 * - case: for higher zoomlevels, this color is for the road's
 *         casing (outline).
 * - fill: for higher zoomlevels, this color is for the road's
 *         inner fill (inline).
 */

@motorway_line:     #ffffff;
@motorway_fill:     #ffffff;
@motorway_case:     @motorway_line * 0.9;

@trunk_line:        #ffffff;
@trunk_fill:        #ffffff;
@trunk_case:        @trunk_line * 0.9;

@primary_line:      #ffffff;
@primary_fill:      #ffffff;
@primary_case:      @primary_line * 0.9;

@secondary_line:    #ffffff;
@secondary_fill:    #ffffff;
@secondary_case:    @secondary_line * 0.9;

@standard_line:     #ffffff;
@standard_fill:     #fff;
@standard_case:     @land * 0.9;

@pedestrian_line:   #ffffff;
@pedestrian_fill:   #ffffff;
@pedestrian_case:   @land;

@cycle_line:        #ffffff;
@cycle_fill:        #ffffff;
@cycle_case:        @land;

@rail_line:         #cdcdcd;
@rail_fill:         #cdcdcd;
@rail_case:         @land;

@aeroway:           #ddd;

/* ================================================================== */
/* BOUNDARY COLORS
/* ================================================================== */

@admin_2:           #999;

/* ================================================================== */
/* LABEL COLORS
/* ================================================================== */

/* We set up a default halo color for places so you can edit them all
   at once or override each individually. */
@place_halo:        fadeout(#fff,34%);

@country_text:      #666;
@country_halo:      @place_halo;

@state_text:        #666;
@state_halo:        @place_halo;

@city_text:         #666;
@city_halo:         @place_halo;

@town_text:         #666;
@town_halo:         @place_halo;

@poi_text:          #666;

@road_text:         #666;
@road_halo:         #fff;

@other_text:        #888;
@other_halo:        @place_halo;

@locality_text:     #aaa;
@locality_halo:     @land;

/* Also used for other small places: hamlets, suburbs, localities */
@village_text:      #888;
@village_halo:      @place_halo;

/* ****************************************************************** */



