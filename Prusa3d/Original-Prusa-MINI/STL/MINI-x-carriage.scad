// Automatically generated from file:  MINI-x-carriage.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_x_carriage = false;

/* [Hidden] */

MINI_x_carriage_spec = [
  "MINI-x-carriage.stl",
  // dimensions (x,y,z)
  [31.423, 69.407, 29.000],
  // position (x,y,z)
  [47.668, 17.593, 0.000],
  ];

module draw_MINI_x_carriage (where=NE)
{
    move_stl_to_origin (MINI_x_carriage_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_x_carriage)
    draw_MINI_x_carriage();

