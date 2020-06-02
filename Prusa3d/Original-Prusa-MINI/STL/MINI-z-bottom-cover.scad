// Automatically generated from file: MINI-z-bottom-cover.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_z_bottom_cover = false;

/* [Hidden] */

MINI_z_bottom_cover_spec = [
  "MINI-z-bottom-cover.stl",
  // dimensions (x,y,z)
  [75.800, 116.900, 16.500],
  // position (x,y,z)
  [5.421, 93.000, 0.000],
  ];

module draw_MINI_z_bottom_cover (where=NE)
{
    move_stl_to_origin (MINI_z_bottom_cover_spec, path="./", where=where);
}

if (show_MINI_z_bottom_cover)
    draw_MINI_z_bottom_cover();

