// Automatically generated from file:  MINI-fsenzor-cover.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_fsenzor_cover = false;

/* [Hidden] */

MINI_fsenzor_cover_spec = [
  "MINI-fsenzor-cover.stl",
  // dimensions (x,y,z)
  [59.000, 24.000, 8.500],
  // position (x,y,z)
  [-39.000, -8.250, 6.750],
  ];

module draw_MINI_fsenzor_cover (where=NE)
{
    move_stl_to_origin (MINI_fsenzor_cover_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_fsenzor_cover)
    draw_MINI_fsenzor_cover();

