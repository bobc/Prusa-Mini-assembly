// File: mini-steel-sheet.stl
mini_steel_sheet_spec = [
  "mini-steel-sheet.stl",
  // dimensions (x,y,z)
  [190.000, 200.000, 1.400],
  // position (x,y,z)
  [-95.000, -102.150, 0.000],
  ];

include <../../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

module draw_mini_steel_sheet (where=NE)
{
    move_stl_to_origin (mini_steel_sheet_spec, path="./", where=where);
}

// draw_mini_steel_sheet();

