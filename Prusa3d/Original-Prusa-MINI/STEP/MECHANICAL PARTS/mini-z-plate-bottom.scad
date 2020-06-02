// File: mini-z-plate-bottom.stl
mini_z_plate_bottom_spec = [
  "mini-z-plate-bottom.stl",
  // dimensions (x,y,z)
  [119.000, 30.000, 5.000],
  // position (x,y,z)
  [-59.000, -15.000, 0.000],
  ];

include <../../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

module draw_mini_z_plate_bottom (where=NE)
{
    move_stl_to_origin (mini_z_plate_bottom_spec, path="./", where=where);
}

// draw_mini_z_plate_bottom();

