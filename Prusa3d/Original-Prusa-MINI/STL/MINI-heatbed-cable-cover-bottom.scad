// Automatically generated from file: MINI-heatbed-cable-cover-bottom.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_heatbed_cable_cover_bottom = false;

/* [Hidden] */

MINI_heatbed_cable_cover_bottom_spec = [
  "MINI-heatbed-cable-cover-bottom.stl",
  // dimensions (x,y,z)
  [35.000, 34.000, 8.500],
  // position (x,y,z)
  [-17.500, -8.500, -0.000],
  ];

module draw_MINI_heatbed_cable_cover_bottom (where=NE)
{
    move_stl_to_origin (MINI_heatbed_cable_cover_bottom_spec, path="./", where=where);
}

if (show_MINI_heatbed_cable_cover_bottom)
    draw_MINI_heatbed_cable_cover_bottom();

