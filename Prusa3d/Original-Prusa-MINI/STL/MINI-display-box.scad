// Automatically generated from file:  MINI-display-box.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_display_box = false;

/* [Hidden] */

MINI_display_box_spec = [
  "MINI-display-box.stl",
  // dimensions (x,y,z)
  [65.930, 112.860, 30.000],
  // position (x,y,z)
  [178.649, 0.100, 0.000],
  ];

module draw_MINI_display_box (where=NE)
{
    move_stl_to_origin (MINI_display_box_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_display_box)
    draw_MINI_display_box();

