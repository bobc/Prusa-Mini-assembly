// Automatically generated from file: MINI-y-plate-rear.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_y_plate_rear = false;

/* [Hidden] */

MINI_y_plate_rear_spec = [
  "MINI-y-plate-rear.stl",
  // dimensions (x,y,z)
  [168.000, 45.500, 54.950],
  // position (x,y,z)
  [377.909, 41.589, 0.000],
  ];

module draw_MINI_y_plate_rear (where=NE)
{
    move_stl_to_origin (MINI_y_plate_rear_spec, path="./", where=where);
}

if (show_MINI_y_plate_rear)
    draw_MINI_y_plate_rear();

