//******************************************************************************
// Description:
// 
// Prusa Mini - Display assembly
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
//$fs=1;
//*************************************

// External libraries
use <../libs/Common/rmc_shapes.scad>
include <../libs/Move-STL-to-origin/stl_move_to_origin.scad>
use <../libs/MCAD/metric_fastners.scad>

// Official Prusa parts
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-knob.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/Mini-display-box.scad>

// Project includes
include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/nuts_bolts_etc.scad>




// assembly
module assembly_display()
  bom_assembly ("Display")
{
  
  translate ([0, -16, 18.5])
  group()
  {
    translate ([0,0,0])
    rotate ([180,0,0])
    color (printed_color_sig)
    bom_printed (MINI_display_box_spec, path=prusa_printed_path, where = SE);

    translate ([16.2,-3.5,12])
    rotate ([180,0,0])
    color (printed_color_base)
    bom_printed (MINI_knob_spec, path=prusa_printed_path, where = SE);
  
    // TODO: Is model of PCB available?
    translate ([11, 5,-11])
    group ()
    {
      bom_ref ("PCB, Mini display")
      {
        color ("green")
        cube  ([51, 104, 1.6]);
      
        color (nearly_black)
        translate ([25, 52, -9/2])
        mirror ([0,0,1])
        open_box ([22.8,9,9], 1);
      }
      
      // PCB screws
      translate ([0, 0, 0])
      {
        for (x=[0,45])
        for (y=[0,97])
          translate ([2.75 + x, 3 + y, 0])
          color (bolt_color)
          part_cap_bolt (3, 8);
      }
    }
  
    // Mount display to Y frame
    translate ([3, 16, -18.5])
    rotate ([0,-90,0])
    color (bolt_color)
    part_cap_bolt (3, 12);
    
    
    // non-BOM bling
    translate ([35, 75, -1])
    color ("white")
    {
      text ("Original", halign="center", font="Arial", size=5);
      translate ([0, -10, 0])
      text ("Prusa", halign="center", font="Arial", size=5);
      translate ([0, -20, 0])
      text ("Mini", halign="center", font="Arial", size=5);
    }
  }
  
  // In BOM but NOT DISPLAYED
  bom_ref ("cable, display 14 way flat");
}

assembly_display();

