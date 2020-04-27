//******************************************************************************
// Description:
// 
// Prusa Mini Y Carriage assembly
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

include  <../libs/Common/rmc_profiles.scad>
use  <../libs/Common/rmc_cylinders.scad>
use  <../libs/Common/rmc_shapes.scad>
use  <../libs/Common/rmc_sections.scad>

include <../libs/move-stl-to-origin/stl_move_to_origin.scad>
include <../libs/mcad/stepper.scad>
include <../libs/mcad/linear_bearing.scad>
use <../libs/mcad/metric_fastners.scad>
use <../libs/mcad/shapes.scad>

// Official Prusa parts

include <../Prusa3d/Original-Prusa-MINI/STL/Mini-y-plate-front.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-y-plate-rear.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-y-idler.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-y-belt-holder.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-heatbed-cable-cover-top.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-heatbed-cable-cover-bottom.scad>
include <../Prusa3d/Original-Prusa-MINI/STEP/MECHANICAL PARTS/MINI-y-carriage.scad>
include <../Prusa3d/Heatbed-Mini-PCB/rev.03b/Heatbed-Mini-PCB.scad>

// Project includes

include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/smooth_rod.scad>
include <vitamins/bearings_etc.scad>
include <vitamins/nuts_bolts_etc.scad>

y_frame_length = 285;

y_profile_len = 262;
y_rod_length  = 279;

y_rod_sep     = 120;


//
show_bed = true;


//******************************************************************************


//******************************************************************************

// assembly
module assembly_y_carriage(y_carriage_pos = 60)
  bom_assembly ("Y Carriage")
{
  
//******************************************************************************
  // main frame
  group()
  {
    rotate ([90,0,180])
    color (printed_color_base)
    bom_printed (MINI_y_plate_front_spec, path=prusa_printed_path, where = NW);

    translate ([0, y_rod_length + 7,0])
    translate ([MINI_y_plate_rear_spec[1][0],
      0,
      MINI_y_plate_rear_spec[1][1]])
    rotate ([-90,0,180])
    color (printed_color_base)
    bom_printed (MINI_y_plate_rear_spec, path=prusa_printed_path, where = NE);
  
    // smooth rods
    translate ([10, 12 - 17/2, 40.5])
    part_rod (y_rod_length);
    
    translate ([10 + y_rod_sep, 12-17/2, 40.5])
    part_rod (y_rod_length);

    group()
    {
      // alu profile
      bom_ref (str("mech, 3030 profile, len=",y_profile_len))
      translate ([31, y_profile_len/2 + 12, 16.5])
      rotate ([0,0,90])
      color (mech_color)
      beam_3030 (y_profile_len);
      
      bom_ref (str("mech, 3030 profile, len=",y_profile_len))
      translate ([31 + 120, y_profile_len/2 + 12, 16.5])
      rotate ([0,0,90])
      color (mech_color)
      beam_3030 (y_profile_len);
    }
    
    // Y-motor, nema17 
    group()
    translate ([79, 253, 22.5])
    {
      bom_ref ("Motor, Nema17")
      rotate ([0,90,0])
        motor (Nema17);

      // for motor
      motor_bolt_pos = [
        [-8, -15.5, -15.5],
        [-8, 15.5, -15.5],
        [-8, 15.5, 15.5]
      ];
      
      for (p=motor_bolt_pos)
        translate (p)
        color (bolt_color)
        rotate ([0,90,0])
        part_cap_bolt (3, 12);
      
      // belt pulley
      translate ([-18.5,-7,-7])
      part_pulley_gt2_16();
    }

    
    // bolts in end of alu profiles
    for (x=[31,31+120])
      for (m=[0,1])
      translate ([x, m*y_frame_length, 0])
      mirror ([0,m,0])
      {
        bom_ref ("bolt, M5x20r button head")
        translate ([-11.6, 0, 16.5-11.6])
        rotate ([-90,0,0])
        color (bolt_color)
        button_head_bolt (5, 20);
    
        bom_ref ("bolt, M5x20r button head")
        translate ([11.6, 0, 16.5+11.6])
        rotate ([-90,0,0])
        color (bolt_color)
        button_head_bolt (5, 20);
      }
      
      
    // T-nuts for Z mounting
    translate ([151, 180, 0])
    {
      translate ([0, 0, 30.9])
      part_t_nut();
      
      translate ([14.4, -19, 16.5])
      rotate ([0,90,0])
      {
        part_t_nut();
        
        translate ([0, 37, 0])
          part_t_nut();
      }
    }
  
    // for display mounting  
    bom_ref ("nut, M3nN nyloc nut")
    translate ([164, 22, 16.5])
    rotate ([0,-90,0])
    rotate ([0,0,30])
    nyloc_nut (3);
    
  } // main frame
  
//******************************************************************************
  
  translate ([56, 18, 0])
  
  group()
  {
    // belt idler/tensioner assembly
      
    translate ([MINI_y_idler_spec[1][0], 0, 0])
      rotate ([90,0,180])
      color (printed_color_base)
      bom_printed (MINI_y_idler_spec, path=prusa_printed_path, where = NE);

    // axle

    translate ([15, 16.5, 23.5])
    rotate ([0,90,0])
    part_idler();
      
    translate ([6, 16.5, 23.5])
    rotate ([0,90,0])
    color(bolt_color)
    part_cap_bolt (3, 20);

    bom_ref ("nut, M3nN nyloc nut")
    translate ([8+16, 16.5, 23.5])
    rotate ([0,90,0])
    rotate ([0,0,30])
    nyloc_nut (3);
    
    // bolts to frame
    translate ([15, -20, 5.5])
    rotate ([-90,0,0])
    color(bolt_color)
    part_cap_bolt (3, 20);
    
    translate ([15, -20, 35.5])
    rotate ([-90,0,0])
    color(bolt_color)
    part_cap_bolt (3, 20);
    
    translate ([15, 7.3, 35.5])
    rotate ([90,0,0])
    part_square_nut();
    
    translate ([15, 7.3, 5.5])
    rotate ([90,0,0])
    part_square_nut();

  }
  
//******************************************************************************
  
  bom_ref ("belt, GT2, len=495mm")  
  translate ([71,145,23.5])
  rotate ([0,0,90])
  pmv_belt (220, 6, 12, 20);

//******************************************************************************
  bed_offset = -3.9;
    
  group()
  {
    
    //custom mech
    if (show_bed)
      translate ([-20, -36+ y_carriage_pos, 50 + bed_offset])
      //translate ([MINI_y_carriage_spec[1][0], 0, 0])
      //rotate ([90,0,180])
      color (mech_color)
        bom_mech (mini_y_carriage_spec, path=prusa_mech_path, where = NE);
    
    bearing_pos = [ 
      [10, 13.8 + y_carriage_pos, 0 ],
      [10, 13.8 + 56.5 + y_carriage_pos, 0 ],
      [10 + y_rod_sep, 14 + 28 + y_carriage_pos, 0 ] ];
    
    for (p=bearing_pos)
    {
      bom_ref ("bearing, LM8UU linear bearing")
      translate ([0, 0, 40.5])
      translate (p)
      rotate ([-90,0,0])
      linearBearing();
    
      translate ([0, 12, 41.5])
      translate (p)
      rotate ([-90,0,0])
      color(bolt_color)
      part_u_bolt(inside_diam=17, inside_height=23);
      
      bom_ref ("nut, M3nN nyloc nut");
      translate ([20/2, 12, 51])
      translate (p)
      nyloc_nut (3);
      
      bom_ref ("nut, M3nN nyloc nut");
      translate ([-20/2, 12, 51])
      translate (p)
      nyloc_nut (3);
    }
    
    // magnetic heatbed
    if (show_bed)
        translate ([75, 30 + y_carriage_pos,26])
        translate ([-MINI_y_belt_holder_spec[1][2], MINI_y_belt_holder_spec[1][0], MINI_y_belt_holder_spec[1][1]])
        rotate ([-90,0,-90])
        color (printed_color_base)
        bom_printed (MINI_y_belt_holder_spec, path=prusa_printed_path, where = NE);

    translate ([70, 94, 44])
    rotate ([0,0,0])
    color(bolt_color)
    part_cap_bolt (3, 8);

    translate ([70, 94+40, 44])
    rotate ([0,0,0])
    color(bolt_color)
    part_cap_bolt (3, 8);
//
    if (show_bed)
      bom_ref ("PCA, Magnetic heatbed Mini")
      translate ([-23, -39 + y_carriage_pos, 57])
      color ("gray")
      move_stl_to_origin (Heatbed_Mini_PCB_spec, path=prusa_heatbed_path, where = NE);

    // bed cable cover
    translate ([127.8, y_carriage_pos + 147.5, 55+6])
      group()
      {
      translate ([35.2, 0, 0])
      rotate ([0,180,0])
      color (printed_color_base)
      bom_printed (MINI_heatbed_cable_cover_bottom_spec, path=prusa_printed_path, where = NE);
    
      translate ([0, 34, 6.5])
      rotate ([0,180,180])
      color (printed_color_base)
      bom_printed (MINI_heatbed_cable_cover_top_spec, path=prusa_printed_path, where = NE);

      translate ([17.7, 8.5, 4])
      rotate ([-180,0,0])
      color(bolt_color)
      part_cap_bolt (3, 14);

      bom_ref ("nut, M3nN nyloc nut")
      translate ([17.7, 8.5, -5])
      rotate ([-180,0,30])
      nyloc_nut (3);
    }
    
    // spacers
      
    spacer_pos = [
      [-15, -31, 0],
      [70, -26, 0],
      [155, -31, 0],

      [-10, 54, 0],
      [70,  54, 0],
      [150, 54, 0],

      [-15, 139, 0],
      [70, 134, 0],
      [155, 139, 0]
      ];
      
    for (p=spacer_pos)
    {
      translate (p)
      translate ([0,y_carriage_pos,0])
      translate ([0, 0, 51])
      part_spacer(3, 6);
      
      // M3 bolt underneath
      translate (p)
      translate ([0,y_carriage_pos,0])
      translate ([0, 0, 51-5])
      color (bolt_color)
      part_cap_bolt (3, 8);

      
      // M3 Torx bolt on top
      translate (p)
      translate ([0,y_carriage_pos,0])
      translate ([0, 0, 52.5+6+1.6])
      color (bolt_color)
      rotate ([180,0,0])
      //csk_bolt (3, 4);
      part_bolt_M3_torx_csk(4);
      
    }
  }
  
//******************************************************************************
}


translate ([0,0,-1.5])
assembly_y_carriage();