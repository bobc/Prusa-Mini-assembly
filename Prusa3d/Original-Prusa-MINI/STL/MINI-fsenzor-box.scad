// Automatically generated from file:  MINI-fsenzor-box.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_fsenzor_box = false;

/* [Hidden] */

MINI_fsenzor_box_spec = [
  "MINI-fsenzor-box.stl",
  // dimensions (x,y,z)
  [58.997, 26.000, 13.000],
  // position (x,y,z)
  [-38.997, -25.000, -9.000],
  ];

module draw_MINI_fsenzor_box (where=NE)
{
    move_stl_to_origin (MINI_fsenzor_box_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_fsenzor_box)
    draw_MINI_fsenzor_box();

