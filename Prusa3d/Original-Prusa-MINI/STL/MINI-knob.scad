// Automatically generated from file: MINI-knob.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_knob = false;

/* [Hidden] */

MINI_knob_spec = [
  "MINI-knob.stl",
  // dimensions (x,y,z)
  [31.299, 36.141, 11.450],
  // position (x,y,z)
  [87.884, 170.499, 0.000],
  ];

module draw_MINI_knob (where=NE)
{
    move_stl_to_origin (MINI_knob_spec, path="./", where=where);
}

if (show_MINI_knob)
    draw_MINI_knob();

