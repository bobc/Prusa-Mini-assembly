// Automatically generated from file: IR-sensor-01.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_IR_sensor_01 = false;

/* [Hidden] */

IR_sensor_01_spec = [
  "IR-sensor-01.stl",
  // dimensions (x,y,z)
  [26.540, 8.000, 8.200],
  // position (x,y,z)
  [-6.040, 0.000, -1.350],
  ];

module draw_IR_sensor_01 (where=NE)
{
    move_stl_to_origin (IR_sensor_01_spec, path="./", where=where);
}

if (show_IR_sensor_01)
    draw_IR_sensor_01();

