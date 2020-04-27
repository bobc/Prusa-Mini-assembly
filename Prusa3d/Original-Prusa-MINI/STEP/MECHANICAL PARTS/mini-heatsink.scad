// File: mini-heatsink.stl
mini_heatsink_spec = [
  "mini-heatsink.stl",
  // dimensions (x,y,z)
  [55.000, 46.000, 12.000],
  // position (x,y,z)
  [-14.000, -50.000, -6.000],
  ];

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

module draw_mini_heatsink (where=NE)
{
    move_stl_to_origin (mini_heatsink_spec, path="C:/github/Original-Prusa-MINI/STEP/MECHANICAL PARTS/", where=where);
}

// draw_mini_heatsink();

