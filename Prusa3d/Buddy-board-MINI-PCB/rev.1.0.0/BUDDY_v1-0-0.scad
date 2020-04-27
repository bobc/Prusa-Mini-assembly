// File: BUDDY_v1-0-0.stl
BUDDY_v1_0_0_spec = [
  "BUDDY_v1-0-0.stl",
  // dimensions (x,y,z)
  [108.084, 71.275, 20.238],
  // position (x,y,z)
  [95.702, -130.560, -2.350],
  ];

include <C:/SCAD_Projects/Move-to-origin/stl_move_to_origin.scad>

module draw_BUDDY_v1_0_0 (where=NE)
{
    move_stl_to_origin (BUDDY_v1_0_0_spec, path="C:/github/Buddy-board-MINI-PCB/rev.1.0.0/", where=where);
}

// draw_BUDDY_v1_0_0();

