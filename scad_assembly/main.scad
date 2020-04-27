//******************************************************************************
// Description:
// 
// Prusa Mini - main assembly
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

// Project includes

include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/smooth_rod.scad>

// Assemblies

use <assembly_y_carriage.scad>
use <assembly_x_axis.scad>
use <assembly_z_axis.scad>
use <assembly_display.scad>

x_pos = 90; // [0:180]
y_pos = 90; // [0:180]
z_pos = 90; // [0:180]

//
show_y_carriage = true;
show_z_axis = true;
show_x_axis = true;
show_display = true;


// assembly
module assembly_main()
{
  if (show_y_carriage)
    assembly_y_carriage(y_pos);  
  
  if (show_z_axis)
    translate ([261, 165, 31.5])
  
  //translate ([0,0, 31.5+3.5])
    assembly_z_axis(z_pos);
  
  if (show_x_axis)
    translate ([231, 164, 87 + z_pos])
    assembly_x_axis(x_pos);
  
  if (show_display)
    translate ([169, 22, 16.5])
    rotate ([45, 0, 0])
    assembly_display ();
  
}

//y_section (600, at=5+20, reverse=false)
bom_assembly ("Main")
  assembly_main();