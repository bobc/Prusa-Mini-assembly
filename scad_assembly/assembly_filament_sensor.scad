//******************************************************************************
// Description:
// 
// Prusa Mini - Filament Sensor assembly
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

include <../libs/MCAD/bearing.scad>
use <../libs/MCAD/metric_fastners.scad>
use <../libs/MCAD/hardware.scad>

// Official Prusa parts
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-fsenzor-box.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-fsenzor-cover.scad>
include <../Prusa3d/Original-Prusa-MINI/STL/MINI-fsenzor-lever.scad>

include <../Prusa3d/MKxS-IR-sensor/rev.01/IR-sensor-01.scad>

// Project includes
include <conf/config.scad>
include <utils/bom.scad>
include <vitamins/nuts_bolts_etc.scad>
include <vitamins/springs.scad>


show_cover = true;

module part_ball_bearing (od)
{
  bom_ref (str("ball bearing, OD=",od));
  
  color (bolt_color)
  render ()
  sphere (d=od);
}

module part_magnet (x,y,z)
{
  bom_ref (str("magnet, ", x, "x", y, "x", z, "mm"));
  
  color ("darkgray")
  render ()
  cube ([x,y,z]);
}

module assembly_filament_sensor ()
  bom_assembly ("filament_sensor")
{

  color (printed_color_base)
  bom_printed (MINI_fsenzor_box_spec, path=prusa_printed_path, where=NE);

  if (show_cover)
    color (printed_color_base)
    translate ([0, 2, MINI_fsenzor_box_spec [IDX_DIMENSION][DIM_Z] + 4])
    rotate ([0,180,180])
    bom_printed (MINI_fsenzor_cover_spec, path=prusa_printed_path, where=SE);
  
  translate ([8, 18, 5])
  rotate ([0,0,180])
  color (printed_color_base)
    bom_printed (MINI_fsenzor_lever_spec, path=prusa_printed_path, where=NW);

  bom_ref ("PCB, IR Sensor")
  color ("darkgray")
  translate ([25.45, 24.2, 5])
  rotate ([90,0,0])
    move_stl_to_origin (IR_sensor_01_spec, path=prusa_ir_sensor_pcb_path, where=NE);
  
  
  translate ([39, 24, 9])
  rotate (DIR_NEG_Y)
    part_cap_bolt (2, 8);

  screw_pos = [[54,15,0], [4,16,0], [23.1, 11.5, -0.8]];
  for (p=screw_pos)
    translate (p)
    translate ([0,0, MINI_fsenzor_box_spec [IDX_DIMENSION][DIM_Z] + 1])
    rotate ([0,180,0])
    part_cap_bolt (3, 12);
  

  translate ([13.8, 7.5, 9])
    part_ball_bearing(7);
  
  magnet_pos = [ [8, 22.4, 3], [9.1, 13.9, 5] ];
  
  translate (magnet_pos[0])
  rotate ([90,0,0])
    part_magnet (6,10,2);
  
  translate (magnet_pos[1])
  rotate ([90,0,0])
    part_magnet (6,8,2);

}

assembly_filament_sensor();
