// Automatically generated from file:  MINI-extruder-front.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_extruder_front = false;

/* [Hidden] */

MINI_extruder_front_spec = [
  "MINI-extruder-front.stl",
  // dimensions (x,y,z)
  [53.000, 63.720, 14.000],
  // position (x,y,z)
  [491.796, 4.352, 0.000],
  ];

module draw_MINI_extruder_front (where=NE)
{
    move_stl_to_origin (MINI_extruder_front_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_extruder_front)
    draw_MINI_extruder_front();

