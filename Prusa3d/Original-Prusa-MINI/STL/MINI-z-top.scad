// Automatically generated from file: MINI-z-top.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_z_top = false;

/* [Hidden] */

MINI_z_top_spec = [
  "MINI-z-top.stl",
  // dimensions (x,y,z)
  [93.374, 50.000, 17.000],
  // position (x,y,z)
  [410.567, 149.100, 0.000],
  ];

module draw_MINI_z_top (where=NE)
{
    move_stl_to_origin (MINI_z_top_spec, path="./", where=where);
}

if (show_MINI_z_top)
    draw_MINI_z_top();

