// Automatically generated from file: MINI-inspection-door.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_inspection_door = false;

/* [Hidden] */

MINI_inspection_door_spec = [
  "MINI-inspection-door.stl",
  // dimensions (x,y,z)
  [28.695, 20.195, 20.450],
  // position (x,y,z)
  [-4.375, -4.375, 0.000],
  ];

module draw_MINI_inspection_door (where=NE)
{
    move_stl_to_origin (MINI_inspection_door_spec, path="./", where=where);
}

if (show_MINI_inspection_door)
    draw_MINI_inspection_door();

