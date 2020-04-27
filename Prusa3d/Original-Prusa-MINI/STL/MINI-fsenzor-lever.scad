// Automatically generated from file:  MINI-fsenzor-lever.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_fsenzor_lever = false;

/* [Hidden] */

MINI_fsenzor_lever_spec = [
  "MINI-fsenzor-lever.stl",
  // dimensions (x,y,z)
  [38.268, 10.193, 8.000],
  // position (x,y,z)
  [-31.001, -5.093, 7.910],
  ];

module draw_MINI_fsenzor_lever (where=NE)
{
    move_stl_to_origin (MINI_fsenzor_lever_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_fsenzor_lever)
    draw_MINI_fsenzor_lever();

