//******************************************************************************
// Description:
// 
// Prusa Mini Hotend assembly
//
// OpenSCAD code Copyright CC-BY-SA Bob Cousins 2020
//
// STL files from prusa3d/Original-Prusa-MINI licensed under the GNU General Public License v3.0 by Prusa Research a.s.
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************


//*************************************
//$fs=0.2;
//*************************************

// External libraries

use <../libs/Common/rmc_sections.scad>
use <../libs/Common/rmc_cuboids.scad>
use <../libs/Common/rmc_cylinders.scad>
use <../libs/Common/rmc_utils.scad>

include <../libs/common/Radial-Cooling-Fan-5015.scad>
use <../libs/MCAD/hardware.scad>
use <../libs/MCAD/metric_fastners.scad>

include <../libs/move-STL-to-origin/stl_move_to_origin.scad>

// Official Prusa parts

include <../Prusa3d/Original-Prusa-MINI/STL/MINI-fan-spacer.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-fan-spacer-clip.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-x-carriage.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-minda-holder.scad>
include <../Prusa3d/Original-Prusa-MINI/STEP/MECHANICAL PARTS/mini-heatsink.scad>

// Project includes

include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/fans.scad>
include <vitamins/smooth_rod.scad>
include <vitamins/bearings_etc.scad>
include <vitamins/nuts_bolts_etc.scad>




module part_radial_fan_5015 ()
{
  bom_ref ("fan, radial 5015, 24V");
  
  move_stl_to_origin (Radial_Cooling_Fan_5015_spec, path=path_common, where=NE);
}

module part_mini_heatbreak()
{
  bom_ref ("Mini heatbreak");
  
  // not sure about length
  len = 39;
  thread_len = 8;
  diam = 5.5;
  
  difference ()
  {
    union()
    {
      translate ([0,0,thread_len])
      cylinder (d=diam, h=len-thread_len);
  
      mock_thread (6, thread_len);
    }
    translate ([0,0,-1])
    cylinder (d=2.5, h=len+2);
  }
}

module part_MINDA()
{
  bom_ref ("MINDA, height probe");
  
  // not sure about length
  len = 36;
  diam = 8;

  color ("silver")
  translate ([0,0,len-5])
  cylinder (d=diam-0.5, h=5);
  
  color ("silver")
  translate ([0,0,5])
    mock_thread (diam, len-5-5);

  color ([0.9, 0.9, 0])
    cylinder (d=diam, h=5);
}


module hotend_assembly ()
  bom_assembly("Hotend")
{
  // X carriage rear
  color (printed_color_base)
  translate ([0, MINI_x_carriage_spec[1][2], 0])
  rotate ([90,0,0])
    bom_printed (MINI_x_carriage_spec, path=prusa_printed_path, where=NE);

  // fan spacer
  color (printed_color_base)
  translate ([6, 1, 14])
  translate ([0, 0, MINI_fan_spacer_spec[1][1]])
  rotate ([90, 0, 0])
  rotate ([0,-90, 180])
    bom_printed (MINI_fan_spacer_spec, path=prusa_printed_path, where=NE);

  // cable guide
  color (printed_color_base)
  translate ([12.35, -3, 55.5])
  rotate ([0,0,180])
    bom_printed (MINI_fan_spacer_clip_spec, path=prusa_printed_path, where=NE);
  
  // MINDA holder
  color (printed_color_base)
  translate ([1.15, 24.05, 5.4])
  translate ([0, -MINI_minda_holder_spec[1][1], 0])
    bom_printed (MINI_minda_holder_spec, path=prusa_printed_path, where = NW);
  
  //fans
  bom_ref ("fan, axial 40x10mm, 24V")
  color (pmv_fan_color)  
  translate ([0.9, -20-1, 20+14.5])
  rotate ([0,90,0])
    fan(fan40x10);
  
  translate ([10.5, 13.4, 6.1])
  rotate_at ([0, 7.5, 47.5], [15,0,0])
  translate ([Radial_Cooling_Fan_5015_spec[IDX_DIMENSION][DIM_Y],
    Radial_Cooling_Fan_5015_spec[IDX_DIMENSION][DIM_X],
    0])
  rotate ([0,-90,90])
  color (pmv_fan_color)
    part_radial_fan_5015();
  
  // heatsink
  bom_ref ("Mini heatsink")
  color (metal_color)
  translate ([12, 5, 14.4])
  rotate ([0,90,0])
    move_stl_to_origin (mini_heatsink_spec, path=prusa_mech_path, where=SW);
    
  translate ([18, -12, 11])
  group ()
  {
    // heater block sub-assembly
   
    // not the right heater block but close
    bom_ref ("heater block, Mini heater block")
    color ("silver")
    rotate ([0,0,90]) 
    mirror ([1,0,0])
    translate ([-4.5,-8, 0])
    rotate ([0,90,0]) 
    import (str(path_common, "e3d-v6hotend_block.stl"));  
    
    color ("silver")
    translate ([0, 0, -6])
    part_mini_heatbreak();
    
    bom_ref ("nozzle, 0.4mm")
    translate ([-4.04, -3.5, -24 + 7])
    rotate ([0,0,0]) 
    import (str(path_common, "v6-_nozzle-0-4mm.stl"));  
  }
  
  translate ([18, -12, 49.5])
    part_pipe_fitting();
  
  translate ([-11.9, -15.1, -5])
    part_MINDA();
  
  // left side screws
  translate ([9.5, 21, 53.7])
  rotate (DIR_X)
  rotate ([0,0,30])
  part_M3_bolt_and_nut (20, 18);
  
  translate ([-15, -5, 8.5])
  rotate (DIR_X)
  rotate ([0,0,30])
  part_M3_bolt_and_nut (12, 9);

  translate ([-6.5, 13, 9])
  rotate (DIR_X)
  part_M3_bolt_and_square_nut (12, 9);

  // to fan
  translate ([-5.5, -37, 18.5])
  rotate (DIR_X)
  part_cap_bolt (3, 18);

  translate ([-4.5, -5, 50.5])
  rotate (DIR_X)
  part_cap_bolt (3, 18);
  
  // 1x clip

  translate ([9, -20, 58])
  rotate (DIR_Y)
  part_cap_bolt (3, 20);
  
  // 3x heatbreak

  for (z=[0,8.5,17])
  translate ([26, -12, 17.4+z])
  rotate (DIR_NEG_X)
  part_cap_bolt (3, 6);
  
  // 2x heatsink to carriage
  
  translate ([18, 18, 31])
  rotate (DIR_NEG_Y)
  rotate ([0,0,30])
  part_cap_bolt (3, 20);

  translate ([18, 19.5, 65.5])
  rotate (DIR_NEG_Y)
  rotate ([0,0,30])
  part_cap_bolt (3, 20);

}


hotend_assembly();

