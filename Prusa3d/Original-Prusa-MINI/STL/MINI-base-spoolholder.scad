// Automatically generated from file: MINI-base-spoolholder.stl
//

include <../../../libs/Move-STL-to-origin/stl_move_to_origin.scad>

show_MINI_base_spoolholder = false;

/* [Hidden] */

MINI_base_spoolholder_spec = [
  "MINI-base-spoolholder.stl",
  // dimensions (x,y,z)
  [144.987, 29.000, 9.000],
  // position (x,y,z)
  [104.910, 168.850, 0.000],
  ];

module draw_MINI_base_spoolholder (where=NE)
{
    move_stl_to_origin (MINI_base_spoolholder_spec, path="./", where=where);
}

if (show_MINI_base_spoolholder)
    draw_MINI_base_spoolholder();

