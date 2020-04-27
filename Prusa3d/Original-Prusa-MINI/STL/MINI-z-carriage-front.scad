// Automatically generated from file:  MINI-z-carriage-front.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_z_carriage_front = false;

/* [Hidden] */

MINI_z_carriage_front_spec = [
  "MINI-z-carriage-front.stl",
  // dimensions (x,y,z)
  [55.500, 29.000, 56.000],
  // position (x,y,z)
  [97.250, 90.500, 0.000],
  ];

module draw_MINI_z_carriage_front (where=NE)
{
    move_stl_to_origin (MINI_z_carriage_front_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_z_carriage_front)
    draw_MINI_z_carriage_front();

