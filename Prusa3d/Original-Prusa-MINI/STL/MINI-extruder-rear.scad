// Automatically generated from file: MINI-extruder-rear.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_extruder_rear = false;

/* [Hidden] */

MINI_extruder_rear_spec = [
  "MINI-extruder-rear.stl",
  // dimensions (x,y,z)
  [53.000, 67.865, 17.000],
  // position (x,y,z)
  [316.211, -12.910, 0.000],
  ];

module draw_MINI_extruder_rear (where=NE)
{
    move_stl_to_origin (MINI_extruder_rear_spec, path="./", where=where);
}

if (show_MINI_extruder_rear)
    draw_MINI_extruder_rear();

