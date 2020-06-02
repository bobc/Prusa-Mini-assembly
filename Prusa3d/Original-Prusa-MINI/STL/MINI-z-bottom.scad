// Automatically generated from file: MINI-z-bottom.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_z_bottom = false;

/* [Hidden] */

MINI_z_bottom_spec = [
  "MINI-z-bottom.stl",
  // dimensions (x,y,z)
  [89.300, 163.935, 42.000],
  // position (x,y,z)
  [85.091, 0.100, 0.000],
  ];

module draw_MINI_z_bottom (where=NE)
{
    move_stl_to_origin (MINI_z_bottom_spec, path="./", where=where);
}

if (show_MINI_z_bottom)
    draw_MINI_z_bottom();

