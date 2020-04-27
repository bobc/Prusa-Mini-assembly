// Automatically generated from file:  MINI-extruder-idler.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_extruder_idler = false;

/* [Hidden] */

MINI_extruder_idler_spec = [
  "MINI-extruder-idler.stl",
  // dimensions (x,y,z)
  [12.500, 58.505, 26.460],
  // position (x,y,z)
  [508.973, 56.904, 0.000],
  ];

module draw_MINI_extruder_idler (where=NE)
{
    move_stl_to_origin (MINI_extruder_idler_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_extruder_idler)
    draw_MINI_extruder_idler();

