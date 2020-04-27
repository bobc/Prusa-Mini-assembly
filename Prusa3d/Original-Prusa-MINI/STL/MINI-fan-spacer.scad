// Automatically generated from file:  MINI-fan-spacer.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_fan_spacer = false;

/* [Hidden] */

MINI_fan_spacer_spec = [
  "MINI-fan-spacer.stl",
  // dimensions (x,y,z)
  [42.500, 49.000, 6.000],
  // position (x,y,z)
  [176.605, 118.960, 0.000],
  ];

module draw_MINI_fan_spacer (where=NE)
{
    move_stl_to_origin (MINI_fan_spacer_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_fan_spacer)
    draw_MINI_fan_spacer();

