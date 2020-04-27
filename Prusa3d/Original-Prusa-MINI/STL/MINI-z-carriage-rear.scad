// Automatically generated from file:  MINI-z-carriage-rear.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_z_carriage_rear = false;

/* [Hidden] */

MINI_z_carriage_rear_spec = [
  "MINI-z-carriage-rear.stl",
  // dimensions (x,y,z)
  [53.000, 56.000, 14.000],
  // position (x,y,z)
  [102.147, 81.262, 0.000],
  ];

module draw_MINI_z_carriage_rear (where=NE)
{
    move_stl_to_origin (MINI_z_carriage_rear_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_z_carriage_rear)
    draw_MINI_z_carriage_rear();

