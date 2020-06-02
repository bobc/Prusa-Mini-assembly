//******************************************************************************
// Description:
// 
// Prusa Mini - Z Axis - assembly
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
include  <../libs/Common/rmc_profiles.scad>

include <../libs/Move-STL-to-origin/stl_move_to_origin.scad>
include <../libs/MCAD/stepper.scad>
include <../libs/MCAD/linear_bearing.scad>
use <../libs/MCAD/metric_fastners.scad>

// Official Prusa parts

include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-bottom.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-top.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-bottom-cover.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-bottom-cable-cover.scad>

include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-carriage-front.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-z-carriage-rear.scad>

include <../Prusa3d/Original-Prusa-MINI/STEP/MECHANICAL PARTS/MINI-z-plate-bottom.scad>

include <../Prusa3d/Buddy-board-MINI-PCB/rev.1.0.0/BUDDY_v1-0-0.scad>

// Project includes

include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/smooth_rod.scad>
include <vitamins/nuts_bolts_etc.scad>
include <vitamins/bearings_etc.scad>

use <assembly_extruder.scad>

z_profile_len = 289;
z_rod_length = 341;


show_z_bottom = true;

module part_trapezoidal_nut ()
{
  bom_ref ("nut, trapezoidal T8x2");
 
  color ("gray") 
  difference ()
  {
    union()
    {
      cylinder (d=12.9, h=10);
      cylinder (d=25, h=4);
    }
    
    translate ([0,0,-1])
    cylinder (d=8, h=12);
    
    for (x=[-1:1])
      translate ([19/2*x, 0, -1])
      cylinder (d=3.5, h=6);
  }
}


module assembly_z_carriage()
  bom_assembly("Z Carriage")
{

  // Z carriage body parts
  group()
  {
    translate ([MINI_z_carriage_rear_spec[IDX_DIMENSION][2] + 
      MINI_z_carriage_front_spec[IDX_DIMENSION][1],
    0,0])
    rotate ([-90,0,90])
    color (printed_color_sig)
      bom_printed (MINI_z_carriage_rear_spec, path=prusa_printed_path, where=SE);

    rotate ([0,0,-90])
    color (printed_color_sig)
      bom_printed (MINI_z_carriage_front_spec, path=prusa_printed_path, where=NW);
  }
  
  // X motor
  translate ([1, 26.5, 29 ])
  {
    bom_ref ("Motor, Nema17, 40mm")
    rotate ([0,-90,0])
    rotate ([0,0,45])
      motor (Nema17);

    // belt pulley
    translate ([1.5, -7,-7])
      part_pulley_gt2_16();
  }
  
  // bolts for motor
  for (y=[0,1])
    translate ([8.5, 4.6 + y*43.8, 29])
    rotate ([0,-90,0])
    part_cap_bolt (3, 12);
  
  // Z bearings
  group()
  {
    bom_ref ("bearing, LM10LUU")
    translate ([29, 6.5, 0.5])
    linearBearing (model="LM10LUU");

    bom_ref ("bearing, LM10LUU")
    translate ([29, 6.5 + 40, 0.5])
    linearBearing (model="LM10LUU");
  }
  
  // trap. nut normally supplied with Z motor?
  translate ([29, 26.5, -4 ])
  part_trapezoidal_nut();
  
  // bolts for trap nut
  for (x=[-1,1])
    translate ([29 + 19/2*x, 26.5, -4 ])
    part_M3_bolt_and_square_nut (20, 17.6);
  
  // these clamp the X rods 
  for (z=[0,1])
  for (y=[0,1])
  translate ([6, 7.5 +y*38, 4.25 + z*46])
  rotate ([0,90,0])
    part_M3_bolt_and_square_nut (12, 10);

  // these bolts clamp the Z body together
  for (z=[0,1])
  for (y=[0,1])
  translate ([40, 18 + y*17, 3 + z*50])
  rotate ([0,-90,0])
    part_M3_bolt_and_square_nut (30, 28);
}


// assembly
module assembly_z_frame (z_pos=90)
  bom_assembly("Z Frame")
{
  
  // printed parts
  group()
  {
    translate ([4.5,-10,mini_z_plate_bottom_spec[1][2] + z_profile_len])
    rotate ([0,0,180])
    color (printed_color_base)
    bom_printed (MINI_z_top_spec, path=prusa_printed_path, where = SE);

    if (show_z_bottom)
    translate ([-98.5, -14, -MINI_z_bottom_spec[1][2]+7 ])
    group()
    {
      color (printed_color_base)
      bom_printed (MINI_z_bottom_spec, path=prusa_printed_path, where = NE);
      
      translate ([5.6, 46.05, 38.5])
      color (printed_color_base)
      bom_printed (MINI_z_bottom_cover_spec, path=prusa_printed_path, where = NE);
     
      translate ([MINI_z_bottom_spec[1][0] - 48, 
        46,
        MINI_z_bottom_spec[1][2] - 3.5 -3])
        rotate ([90,0,180])
        color (printed_color_base)
        bom_printed (MINI_z_bottom_cable_cover_spec, path=prusa_printed_path, where=NW);
      
      // bolt through bottom cable cover
      translate ([49, 50, 43])
      rotate ([0,180,0])
      part_M3_bolt_and_square_nut (12, 8);

      // bolts through z bottom plate
      group()
      {
        screw_pos = [ [8.5, 17.8],
          [63.5, 17.8],
          [39.5, 39],
        ];
        
        translate ([0, 0, 34+5.35])
        for (p=screw_pos)
        translate (p)
        rotate ([0,180,0])
        part_M3_bolt_and_square_nut (18, 14.45);
      }


      // bolts clamping lower of Z rods
      group()
      {
        screw_pos = [ 
          [26.5, 0, 5],
          [52.5, 0, 5],
          [26.5, 0, 30],
          [52.5, 0, 30],
        ];
        
        translate ([0, 17, 0])
        for (p=screw_pos)
        translate (p)
        rotate ([-90,0,0])
        part_M3_bolt_and_square_nut (25, 20.4);
      }
    }
  }

  // attach to Y-carriage profile
  group()
  {
    translate ([-110, 15, 5.35])
      rotate ([0,180,0])
      part_cap_bolt (3, 12);

    translate ([-81, -4, -15])
      rotate (DIR_NEG_X)
      part_cap_bolt (3, 20);
    
    translate ([-61, -4+37, -15])
      rotate (DIR_NEG_X)
      part_cap_bolt (3, 40);
  }
//  
  if (show_z_bottom)
  {
    translate ([-15.9, 41.6, -30.5])
    translate ([-BUDDY_v1_0_0_spec[IDX_DIMENSION][DIM_Y],0,0])
    group()
    {
      bom_ref ("PCB,Buddy board")
      rotate ([0,0,90])
      color("lightgray")
      move_stl_to_origin (BUDDY_v1_0_0_spec, path=prusa_buddy_pcb_path, where=SE);
      
      screw_pos = [ [12, 5],
      [65, 17],
      [22, 84],
      [65, 100] ];
      
      for (p=screw_pos)
        translate (p)
        translate ([0,0,4])
        rotate ([0,180,30])
        part_M3_bolt_and_nut (8, 5.5);
    }
  }
  
  // smooth rods
  translate ([0, 0, -30])
  group()
  {
    translate ([-39, 15, 0])
      rotate ([90,0,0])
      part_rod (z_rod_length, 10);
    
    translate ([-39 - 40, 15, 0])
    rotate ([90,0,0])
      part_rod (z_rod_length, 10);
  }
  
  // alu profile
  group()
  {
    bom_ref (str("mech, 3030 profile, len=",z_profile_len))
    translate ([-15,15, mini_z_plate_bottom_spec[1][2] + z_profile_len/2 ])
    rotate ([0,90,0])
    color (mech_color)
    beam_3030 (z_profile_len);
  }

  // bolts attaching profile  
  // bottom
  translate ([-15,15,0])
  {
    bom_ref ("bolt, M5x20r button head")
    translate ([-11.6, 11.6, 0])
    rotate ([0,0,0])
    color (bolt_color)
    button_head_bolt (5, 20);

    bom_ref ("bolt, M5x20r button head")
    translate ([11.6, -11.6, 0])
    rotate ([0,0,0])
    color (bolt_color)
    button_head_bolt (5, 20);
  }

  // top
  translate ([-15,15, z_profile_len+17])
  {
    bom_ref ("bolt, M5x20r button head")
    translate ([-11.6, 11.6, 0])
    rotate ([-180,0,0])
    color (bolt_color)
    button_head_bolt (5, 20);

    bom_ref ("bolt, M5x20r button head")
    translate ([11.6, -11.6, 0])
    rotate ([-180,0,0])
    color (bolt_color)
    button_head_bolt (5, 20);
  }
  
  //custom mech
  if (show_z_bottom)
    translate ([0,0,0])
    translate ([0,0,mini_z_plate_bottom_spec[1][2]])
    rotate ([180,0,180])
    color (mech_color)
    bom_mech (mini_z_plate_bottom_spec, path=prusa_mech_path, where = NE);
    
  // Z-motor, nema17 
  bom_ref ("Motor, Nema17, leadscrew=TR8x4, 210mm")
  group()
  {
    translate ([-15 - 44, 15, mini_z_plate_bottom_spec[1][2] + z_profile_len + MINI_z_top_spec[1][2] ])
    
    rotate ([0,0,45])
    {
      motor (Nema17, size=NemaShort);
 
      // TODO: check length
      shaft_len = 320;
      
      translate ([0,0,-shaft_len])
      color (bolt_color) 
      mock_thread (8, shaft_len);   
    }
  }

  // clamp Z rod top
  for (x=[0,-23])
  translate ([-47.5+x, 6, z_profile_len+15])
    rotate (DIR_Y)
    part_M3_bolt_and_square_nut (20, 18);

}

module assembly_z_axis (z_pos=90)
  bom_assembly("Z Axis")
{
  assembly_z_frame();
  
  //
  translate ([-32.5, 0, mini_z_plate_bottom_spec[1][2] + 40 + z_pos])
  group()
  {
    translate ([0, -14, 0])
    rotate ([0,0,90])
    assembly_z_carriage();

    translate ([0, 60+0.1, -2])
    rotate ([0,0,90])
      extruder_assembly ();  
  }
}

assembly_z_axis();

