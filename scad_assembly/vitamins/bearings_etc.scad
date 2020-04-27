//******************************************************************************
// Description:
// 
// Vitamins - Bearings, pulleys, idlers, belts
//
// Copyright CC-BY-SA Bob Cousins 2020
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************

use <../utils/bom.scad>

// imports <../Common/GT2_16Y.stl>


module part_idler ()
{
  bom_ref ("bearing, 623h smooth idler");  

  h = 9;
  flange_d = 18;
  flange_thick = 1;
  inner_d = 12;
  hole_d = 3.2;
  
  color (bolt_color)
  render($fs=1)
  difference ()
  {
    union ()
    {
      cylinder (d=inner_d, h=h, center=true);
      
      translate ([0,0,h/2-flange_thick/2])
        cylinder (d=flange_d, h=flange_thick, center=true);
      
      translate ([0,0,-h/2+flange_thick/2])
        cylinder (d=flange_d, h=flange_thick, center=true);
    }
    
    cylinder (d=hole_d, h=h+1, center=true);
  }
}

module part_pulley_gt2_16()
{
  bom_ref ("pulley, GT2 16T");  
  
  color (bolt_color)
  import ("../libs/Common/GT2_16T.stl");
}

module pmv_belt (len, width=4, diam1, diam2)
{
    belt_thick = 2;
        
    color ("black")
    {    
      translate ([0,0,diam1/2 + belt_thick/2])
      cube ([len, width, belt_thick], center=true);
      
      translate ([0,0,-diam1/2 - belt_thick/2])
      cube ([len, width, belt_thick], center=true);
    }
}

