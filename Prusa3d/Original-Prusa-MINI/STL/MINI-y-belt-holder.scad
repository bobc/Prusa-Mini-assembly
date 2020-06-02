// Automatically generated from file: MINI-y-belt-holder.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_y_belt_holder = false;

/* [Hidden] */

MINI_y_belt_holder_spec = [
  "MINI-y-belt-holder.stl",
  // dimensions (x,y,z)
  [48.000, 24.000, 13.000],
  // position (x,y,z)
  [493.440, 4.712, 0.000],
  ];

module draw_MINI_y_belt_holder (where=NE)
{
    move_stl_to_origin (MINI_y_belt_holder_spec, path="./", where=where);
}

if (show_MINI_y_belt_holder)
    draw_MINI_y_belt_holder();

