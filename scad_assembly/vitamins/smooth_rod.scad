//******************************************************************************
// Description:
// 
// Vitamins - Smooth rods
//
// Copyright CC-BY-SA Bob Cousins 2020
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************


use <../utils/bom.scad>


module part_rod (length, diam=8)
{
  bom_ref (str("smooth rod,D=",diam,"mm,len=", length, "mm"));
  
  rotate ([-90,0,0])
  color ("silver")
  cylinder (d=diam, length);
}
