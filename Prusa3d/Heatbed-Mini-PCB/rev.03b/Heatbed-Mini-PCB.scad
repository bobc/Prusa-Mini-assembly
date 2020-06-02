// File: Heatbed-Mini-PCB.stl
Heatbed_Mini_PCB_spec = [
  "Heatbed-Mini-PCB.stl",
  // dimensions (x,y,z)
  [186.000, 202.400, 4.150],
  // position (x,y,z)
  [-3.000, -3.000, 0.000],
  ];

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

module draw_Heatbed_Mini_PCB (where=NE)
{
    move_stl_to_origin (Heatbed_Mini_PCB_spec, path="./", where=where);
}

// draw_Heatbed_Mini_PCB();

