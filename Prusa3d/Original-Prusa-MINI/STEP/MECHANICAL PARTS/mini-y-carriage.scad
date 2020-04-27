// File: mini-y-carriage.stl
mini_y_carriage_spec = [
  "mini-y-carriage.stl",
  // dimensions (x,y,z)
  [180.000, 180.000, 5.000],
  // position (x,y,z)
  [-90.000, -90.000, 0.000],
  ];

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

module draw_mini_y_carriage (where=NE)
{
    move_stl_to_origin (mini_y_carriage_spec, path="C:/github/Original-Prusa-MINI/STEP/MECHANICAL PARTS/", where=where);
}

// draw_mini_y_carriage();

