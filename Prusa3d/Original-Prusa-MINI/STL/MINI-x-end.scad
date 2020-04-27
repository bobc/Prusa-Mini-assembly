// Automatically generated from file:  MINI-x-end.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_x_end = false;

/* [Hidden] */

MINI_x_end_spec = [
  "MINI-x-end.stl",
  // dimensions (x,y,z)
  [46.000, 24.000, 28.500],
  // position (x,y,z)
  [125.183, 170.035, 0.000],
  ];

module draw_MINI_x_end (where=NE)
{
    move_stl_to_origin (MINI_x_end_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_x_end)
    draw_MINI_x_end();

