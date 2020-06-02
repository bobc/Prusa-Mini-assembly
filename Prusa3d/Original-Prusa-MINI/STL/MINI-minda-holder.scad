// Automatically generated from file: MINI-minda-holder.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_minda_holder = false;

/* [Hidden] */

MINI_minda_holder_spec = [
  "MINI-minda-holder.stl",
  // dimensions (x,y,z)
  [21.979, 65.500, 17.748],
  // position (x,y,z)
  [22.918, 21.500, 0.000],
  ];

module draw_MINI_minda_holder (where=NE)
{
    move_stl_to_origin (MINI_minda_holder_spec, path="./", where=where);
}

if (show_MINI_minda_holder)
    draw_MINI_minda_holder();

