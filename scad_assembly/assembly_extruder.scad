//******************************************************************************
// Description:
// 
// Prusa Mini - Extruder assembly
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
use <../libs/Common/rmc_cylinders.scad>

include <../libs/Move-STL-to-origin/stl_move_to_origin.scad>
include <../libs/MCAD/stepper.scad>
include <../libs/MCAD/bearing.scad>
use <../libs/MCAD/metric_fastners.scad>
use <../libs/MCAD/hardware.scad>
use <../libs/MCAD/gears.scad>

// Official Prusa parts
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-extruder-front.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-extruder-idler.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-extruder-rear.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-inspection-door.scad>

// Project includes
include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/nuts_bolts_etc.scad>
include <vitamins/springs.scad>


show_front = true;
show_back  = true;
show_lever = true;
show_motor = true;


// approximation only
// small gear fits to motor shaft
module extruder_gear()
{
  len = 10;
  diam = 12;
  num_teeth = 17;

  color ("silver")
  render()
  difference ()
  {
    union()
    {
      rotate ([0,0,360/num_teeth/2])
      linear_extrude (height=len/2)
        gear (num_teeth, diametral_pitch=num_teeth/18*2*10/diam);
      cylinder (d=diam-2, h=len);
    }
    
    translate ([0,0,-1])
      cylinder (d=5, h=len+2);
  }
}

// approximation only
// large gear with hobbing which drives filament
module extruder_drive_gear()
{
  //offset, od, height
  stack = [
    [0, 5, 28],
    [6, 6, 16],
    [8, 8.5, 12],
  ];
  
  diam_gear = 24;
  len_gear  = 3;
  num_teeth = 35;

  color ("silver")
  render()
  difference ()
  {
    union()
    {
      for (p=stack)
        translate ([0,0,p[0]])
        cylinder (d=p[1], h=p[2]);
      
      translate ([0,0,8])
      linear_extrude (height=len_gear)
        gear (num_teeth, diametral_pitch=num_teeth/18*2*10/diam_gear);
    }
    
    ring_r = 1.75/2;
    translate ([0,0,17.2])
    torus (8/2 + ring_r, ring_r, $fs=0.3);
  }
}

module extruder_assembly ()
  bom_assembly ("Extruder")
{
  h = 5;

  if (show_front)
    color (printed_color_sig)
    rotate ([0,0,90])
    rotate ([-90,0,0])
    translate ([0, -MINI_extruder_front_spec[IDX_DIMENSION][1], 0])
      bom_printed (MINI_extruder_front_spec, path=prusa_printed_path, where=NE);

  if (show_lever)
    color (printed_color_sig)
    translate ([-0.25, 0, -6])
    translate ([-MINI_extruder_front_spec[IDX_DIMENSION][2], 
      MINI_extruder_front_spec[IDX_DIMENSION][0], 
      0])
    translate ([-MINI_extruder_idler_spec[IDX_DIMENSION][0], 
      0,
      0])
    rotate ([90,0,0])
    bom_printed (MINI_extruder_idler_spec, path=prusa_printed_path, where=NE);

  color (printed_color_sig)
  translate ([-23.7, 3.6, 47.6])
  rotate ([90,0,90])
  //translate ([0, -MINI_extruder_front_spec[IDX_DIMENSION][1], 0])
    bom_printed (MINI_inspection_door_spec, path=prusa_printed_path, where=NE);


  if (show_back)
  {
    color (printed_color_sig)
    render()
    {
      translate ([-0, 0, -2])
      translate ([-MINI_extruder_front_spec[IDX_DIMENSION][2]
        -MINI_extruder_rear_spec[IDX_DIMENSION][2],
        0, 0])
      rotate ([0,0,90])
      rotate ([90,0,0])
        bom_printed (MINI_extruder_rear_spec, path=prusa_printed_path, where=NE);
    }
  }

  // nut and bolts etc

  // tension bolt/spring
  translate ([-20.25, 7, 4])
  rotate (DIR_Y)
  group()
  {
    //                 OD, Gauge, length, coils
    extruder_spring = [ 7,     1,  32,     12];

    part_M3_bolt_and_square_nut (40, 36.1);

    bom_ref ("spring, OD=7mm, len=32mm");
    color (pmv_spring_color)
    translate ([0, 0, 0])
    comp_spring (extruder_spring);
  }
  

  extruder_x_dim = MINI_extruder_front_spec[IDX_DIMENSION][2] + 
    MINI_extruder_rear_spec[IDX_DIMENSION][2];

  translate([-extruder_x_dim,0,0])
  {
    translate ([4.25, 5.3, 27.9])
    rotate (DIR_X)
      part_M3_bolt_and_nut (12, 10);

    translate ([4.25, 4.5, 45])
    rotate (DIR_X)
      part_M3_bolt_and_nut (25, 23);

    // ?
    translate ([4.25, 38.5, 13])
    rotate (DIR_X)
      part_M3_bolt_and_nut (25, 23);

    translate ([4.25, 34.5, 58])
    rotate (DIR_X)
      part_M3_bolt_and_nut (25, 23);


    // motor screws
    translate ([22.5, 2.6, 30])
    rotate (DIR_X)
      part_cap_bolt (3, 12);

    translate ([22.5, 2.6+43.8, 30])
    rotate (DIR_X)
      part_cap_bolt (3, 12);

    // bearings for filament drive shaft
    for (x=[0,23])
      bom_ref ("bearing, 625Z")
      translate ([0+x, 24.5, 46.4])
      rotate (DIR_X)
      color (bearing_color)
      render()
      bearing (model=625, outline=false);
  }

  // from other side
  
  translate ([-9.5, 0, 0])
  {
    translate ([0, 9.5, 10])
    rotate (DIR_NEG_X)
      part_cap_bolt (3, 25);

    translate ([0, 8, 10+42])
    rotate (DIR_NEG_X)
      part_cap_bolt (3, 25);
  }
  
  translate ([-7.5, 46.5, 47])
    rotate (DIR_NEG_X)
    rotate ([0,0,30])
    part_M3_bolt_and_nyloc_nut (25, 21);

  // pressure idler
  if (show_lever)
    translate ([-22.75, 33.5, 37.5])
    rotate (DIR_X)
    group()
    {
      // bearing
      bom_ref ("bearing, 625Z")
      color (bearing_color)
      render()
      bearing (model=625);

      // axle shaft for bearing
      bom_ref ("shaft, OD=4.9,len=12mm")
      color (bolt_color)
      translate ([0,0, -6 + bearingWidth(625)/2])
      cylinder (d=4.9, h=12);
    }


  bom_ref ("gear, extruder gear (large)")
  translate ([-14, 24.5, 30])
  rotate (DIR_X)
  extruder_gear();

  bom_ref ("gear, extruder gear (small)")
  translate ([-3, 24.5, 46.4])
  rotate (DIR_NEG_X)
  extruder_drive_gear();


  // Bowden fitting
  translate ([-20.25, 0, 15.55])
  rotate ([-45,0,0])
  translate ([0, 0, 59.5])
    part_pipe_fitting();


  // E-motor
  if (show_motor)
    bom_ref ("Motor, Nema17")
    translate ([-0.8, 24.5, 30])
    rotate ([0, 90, 0])
    rotate ([0, 0, 45])
      motor (Nema17);



  //******************************************************************************
  
  // Non-BOM bling
  
  // show filament path through extruder
  translate ([-20.25, 0, 15.55])
  rotate ([-45,0,0])
  translate ([0, 0, 30])
  union()
  {
    color("blue")
    cylinder (r=1.75/2, h = 130, center=true, $fs=0.2);
  }
}

extruder_assembly();


//$vpr = [-45,0,0];   //view down filament
//$vpr = [90,-45,90]; // view with filament horizontal

