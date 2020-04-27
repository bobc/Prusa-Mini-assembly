// Automatically generated from file:  MINI-z-bottom-cable-cover.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_z_bottom_cable_cover = false;

/* [Hidden] */

MINI_z_bottom_cable_cover_spec = [
  "MINI-z-bottom-cable-cover.stl",
  // dimensions (x,y,z)
  [46.000, 13.000, 22.300],
  // position (x,y,z)
  [454.107, 1.105, 0.000],
  ];

module draw_MINI_z_bottom_cable_cover (where=NE)
{
    move_stl_to_origin (MINI_z_bottom_cable_cover_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_z_bottom_cable_cover)
    draw_MINI_z_bottom_cable_cover();

