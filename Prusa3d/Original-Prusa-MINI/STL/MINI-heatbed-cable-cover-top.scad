// Automatically generated from file: MINI-heatbed-cable-cover-top.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_heatbed_cable_cover_top = false;

/* [Hidden] */

MINI_heatbed_cable_cover_top_spec = [
  "MINI-heatbed-cable-cover-top.stl",
  // dimensions (x,y,z)
  [35.340, 32.750, 11.500],
  // position (x,y,z)
  [107.330, 88.625, 0.000],
  ];

module draw_MINI_heatbed_cable_cover_top (where=NE)
{
    move_stl_to_origin (MINI_heatbed_cable_cover_top_spec, path="./", where=where);
}

if (show_MINI_heatbed_cable_cover_top)
    draw_MINI_heatbed_cable_cover_top();

