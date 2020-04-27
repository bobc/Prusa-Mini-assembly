// Automatically generated from file:  MINI-fan-spacer-clip.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_fan_spacer_clip = false;

/* [Hidden] */

MINI_fan_spacer_clip_spec = [
  "MINI-fan-spacer-clip.stl",
  // dimensions (x,y,z)
  [23.344, 15.000, 10.000],
  // position (x,y,z)
  [177.183, 173.955, 0.000],
  ];

module draw_MINI_fan_spacer_clip (where=NE)
{
    move_stl_to_origin (MINI_fan_spacer_clip_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_fan_spacer_clip)
    draw_MINI_fan_spacer_clip();

