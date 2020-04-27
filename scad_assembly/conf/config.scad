//******************************************************************************
// Description:
// 
// Prusa Mini Configuration
//
// OpenSCAD code Copyright CC-BY-SA Bob Cousins 2020
//
// STL files from prusa3d/Original-Prusa-MINI licensed under the GNU General Public License v3.0 by Prusa Research a.s.
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************

//******************************************************************************
/* [Hidden] */

//Disable $fn and $fa, do not change these
$fn=0;
$fa=0.01;

//Use only $fs to control the number of facets globally.
// fine ~ 0.5  coarse ~ 1-2
$fs=1;

//******************************************************************************


prusa_printed_path    = "../Prusa3d/Original-Prusa-MINI/STL/";
prusa_mech_path       = "../Prusa3d/Original-Prusa-MINI/STEP/MECHANICAL PARTS/";
prusa_printed_path_r1 = "../Prusa3d/Original-Prusa-MINI-R1/STL/";
prusa_heatbed_path    = "../Prusa3d/Heatbed-Mini-PCB/rev.03b/";
prusa_buddy_pcb_path  = "../Prusa3d/Buddy-board-MINI-PCB/rev.1.0.0/";
prusa_ir_sensor_pcb_path  = "../Prusa3d/MKxS-IR-sensor/rev.01/";

path_common = "../libs/Common/";

// Official Prusa orange, aka Pantone Orange 21C
prusa_orange = [254/255, 80/255, 0];

nearly_black = [0.2, 0.2, 0.2];

printed_color_sig  = "orange"; 
printed_color_base = "gray"; // "black"; // black loses all highlights in OpenScad

// color for anodised parts
// alu profiles, y frog, z bottom plate
mech_color = "salmon";

// bolts, nuts
bolt_color = "silver";

// generic metal color for alu, steel parts
metal_color = "silver";

// for fans
pmv_fan_color = "darkgray";

// springs
pmv_spring_color = "gray";

bearing_color = [0.65, 0.67, 0.72]; // "steel";

xray_color      = [0.8, 0.8, 0.8, 0.5];
highlight_color = [1, 0.4, 0.4, 0.5];

// config - BOM
BOM_NONE        = 0;
BOM_ASSEMBLIES  = 1;
BOM_STLS        = 2;
BOM_VITAMINS    = 3;
BOM_ALL         = 3;  // the highest

show_bom_level = BOM_ALL;


// useful directions

DIR_X = [0,90,0];
DIR_NEG_X = [0,-90,0];

DIR_Y = [-90,0,0];
DIR_NEG_Y = [90,0,0];

