// Automatically generated from file:  MINI-y-plate-front.stl
//

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

show_MINI_y_plate_front = false;

/* [Hidden] */

MINI_y_plate_front_spec = [
  "MINI-y-plate-front.stl",
  // dimensions (x,y,z)
  [175.000, 45.500, 41.950],
  // position (x,y,z)
  [-45.000, -40.500, -0.000],
  ];

module draw_MINI_y_plate_front (where=NE)
{
    move_stl_to_origin (MINI_y_plate_front_spec, path="C:/github/Original-Prusa-MINI/STL/", where=where);
}

if (show_MINI_y_plate_front)
    draw_MINI_y_plate_front();

