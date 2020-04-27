// Automatically generated from file:  MINI-y-idler.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_y_idler = false;

/* [Hidden] */

MINI_y_idler_spec = [
  "MINI-y-idler.stl",
  // dimensions (x,y,z)
  [29.900, 40.000, 23.000],
  // position (x,y,z)
  [-14.950, -23.500, -0.000],
  ];

module draw_MINI_y_idler (where=NE)
{
    move_stl_to_origin (MINI_y_idler_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_y_idler)
    draw_MINI_y_idler();

