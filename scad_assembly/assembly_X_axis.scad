//******************************************************************************
// Description:
// 
// Prusa Mini - X Axis - assembly
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
use  <../libs/Common/rmc_sections.scad>

include <../libs/Move-STL-to-origin/stl_move_to_origin.scad>
include <../libs/MCAD/linear_bearing.scad>
use <../libs/MCAD/metric_fastners.scad>

// Official Prusa parts
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-x-end.scad>
include <../Prusa3d/Original-Prusa-MINI/STEP/MECHANICAL PARTS/MINI-z-plate-bottom.scad>

// Project includes

include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/smooth_rod.scad>
include <vitamins/bearings_etc.scad>
include <vitamins/nuts_bolts_etc.scad>

use <assembly_hotend.scad>

x_rod_length = 279;

// actually center to center distance
x_belt_dist = 250;

module assembly_x_carriage(x_pos=0)
  bom_assembly ("X Carriage")
{

  translate ([-x_rod_length + 20 + x_pos, 0, 0])
  {
    bom_ref ("bearing, LM8UU")
    translate ([0, 0, 0])
    rotate ([0,90,0])
    linearBearing (model="LM8UU");

    bom_ref ("bearing, LM8UU")
    translate ([0, 0, 34])
    rotate ([0,90,0])
    linearBearing (model="LM8UU");
  }
  
  // X end
  translate ([-x_rod_length-13, -11, -6])
  group()
  {
    rotate ([0,-90,180])
    color (printed_color_sig)
    bom_printed (MINI_x_end_spec, path=prusa_printed_path, where = SE);
  
    // idler axle
    translate ([12, 2, 23])
    rotate ([0,0,90])
    {
      translate ([9, 0, 0])
      rotate ([0,90,0])
      part_idler();
        
      translate ([2, 0, 0])
      rotate ([0,90,0])
      color(bolt_color)
      part_cap_bolt (3, 20);

      bom_ref ("nut, M3nN nyloc nut")
      translate ([18, 0, 0])
      rotate ([0,90,0])
      rotate ([0,0,30])
      nyloc_nut (3);
    }
    
    // rod clamp
    translate ([23.5, 7, 34])
    rotate ([0,90,90])
    color(bolt_color)
    part_cap_bolt (3, 12); // len ?
    
    translate ([23.5, 7, 12])
    rotate ([0,90,90])
    color(bolt_color)
    part_cap_bolt (3, 12);

    translate ([23.5, 18.7, 34])
    rotate ([90,0,0])
    part_square_nut();

    translate ([23.5, 18.7, 12])
    rotate ([90,0,0])
    part_square_nut();
    
    // tensioners for X belt
    translate ([4, 11, 6])
    rotate ([0,90,0])
    color(bolt_color)
    part_cap_bolt (3, 12);

    translate ([4, 11, 6+34])
    rotate ([0,90,0])
    color(bolt_color)
    part_cap_bolt (3, 12);
  } // X end
  
  
  // smooth rods
  group()
  {
    translate ([0, 0, 0])
      rotate ([0, 0, 90])
      part_rod (x_rod_length, 8);
    
    translate ([0, 0, 34])
    rotate ([0,0, 90])
      part_rod (x_rod_length, 8);
  }
  
  bom_ref ("belt, GT2, len=495mm")  
  translate ([-x_belt_dist/2 -20, 0, 17])
  pmv_belt (x_belt_dist,6,10,10);
}


// assembly
module assembly_x_axis(x_pos=90)
{
  
  rotate ([0,0,0])
    assembly_x_carriage(x_pos);
  
  translate ([-x_rod_length + 14 + x_pos, 0, 0])
  translate ([0, -9, -21.4])
  rotate ([0,0,0])
    hotend_assembly ();

  
}

assembly_x_axis();

