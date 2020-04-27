// File: Radial-Cooling-Fan-5015.stl
Radial_Cooling_Fan_5015_spec = [
  "Radial-Cooling-Fan-5015.stl",
  // dimensions (x,y,z)
  [51.300, 15.000, 51.067],
  // position (x,y,z)
  [-27.500, 0.000, -25.667],
  ];

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

module draw_Radial_Cooling_Fan_5015 (where=NE)
{
    move_stl_to_origin (Radial_Cooling_Fan_5015_spec, path="C:/SCAD_Projects/Common/", where=where);
}

// draw_Radial_Cooling_Fan_5015();

