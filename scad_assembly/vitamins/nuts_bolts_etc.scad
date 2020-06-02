//******************************************************************************
// Description:
// 
// Vitamins - Nuts, bolts, spacers
//
// Copyright CC-BY-SA Bob Cousins 2020
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************

use <../utils/bom.scad>

use <../utils/utilities.scad>

// use <../MCAD/metric_fastners.scad>
// use <../MCAD/shapes.scad>

// use <../Common/rmc_cylinders.scad>
// use <../Common/rmc_shapes.scad>


module part_square_nut ()
{
  bom_ref ("nut, M3 square nut");

  color(bolt_color)
  render()
  square_nut (3);
}  

module part_cap_bolt (diam, len)
{
  bom_ref (str("bolt, M",diam,"x",len," cap bolt"));

  color(bolt_color)
  render()
  cap_bolt (diam, len);
}  

module part_M3_bolt_and_nut (len, nut_pos)
{
  bom_ref ("nut, M3 nut");
  bom_ref (str("bolt, M3x", len, " cap bolt"));

  color(bolt_color)
  render()
  cap_bolt_plus (3, len, nut_pos=nut_pos, nut_style=0);
}  

module part_M3_bolt_and_square_nut (len, nut_pos)
{
  bom_ref ("nut, M3 square nut");
  bom_ref (str("bolt, M3x", len, " cap bolt"));

  color(bolt_color)
  render()
  cap_bolt_plus (3, len, nut_pos=nut_pos, nut_style=1);
}  

module part_M3_bolt_and_nyloc_nut (len, nut_pos)
{
  bom_ref ("nut, M3nN nyloc nut");
  bom_ref (str("bolt, M3x", len, " cap bolt"));

  color(bolt_color)
  render()
  cap_bolt_plus (3, len, nut_pos=nut_pos, nut_style=2);
}  

module part_u_bolt (wire_d=3, inside_diam=15, inside_height=20)
{
  bom_ref ("bolt, U-bolt, M3, inside_diam=17mm, inside_len=23mm");

  radius = inside_diam/2;
  wire_r = wire_d/2;
  len = inside_height - radius;
  
  {
    torus_seg_ang (radius + wire_r, wire_r, 180);
    
    for (p=[-1,1])
    translate ([(radius+wire_r)*p, 0, 0])
    rotate ([90,0,0])
    cylinder (r=wire_r, h=len);
  }

  //cylinder (r=inside_diam/2, h=10);
}

module part_spacer (id=3, len=6)
{
  bom_ref ("spacer, threaded hex spacer, M3, len=6mm");

  od = id + 2;
  
  color (bolt_color)
  difference ()
  {
    cylinder (r=od/2, h=len, $fn=6);
    translate ([0,0,-1])
    cylinder (r=id/2, h=len+2);
  }
}


module part_t_nut ()
  // T-nut for 3030 profile
{
  bom_ref ("nut, M3 T-nut for 3030 profile");

  len = 14.8;
  hole_d = 3;
  
  // cross section dimensions
  // width, y offset
  spec = [
    [8,    0],
    [8,    1.5],
    [13.4, 1.5],
    [13.4, 3],
    [8,    6.2]
  ];

  color(bolt_color)
  render()
  difference ()
  {
    translate ([0,-len/2,0])
    rotate ([-90,0,0])
    prism_builder (spec, len);
    
    
    translate ([0,0,-7])
    cylinder (d=hole_d, h=8);
  }
}

module part_bolt_M3_torx_csk (len)
{
  bom_ref (str("bolt, M3x", len, " countersunk Torx low profile"));

  render()
  difference ()
  {
    csk_bolt (3, len);
    6pointStar (2.5, 2);  
  }
}

// low poly thread, for show
module mock_thread (diam=6, len=10)
{
  pitch = diam/6;
  pts = [ 
      [0,0],
      for (j=[0:len/pitch*2]) [diam/2 - j%2 * pitch/sqrt(2), j/2*pitch] ,
      [diam/2, len],
      [0,len]
    ];
  
  rotate_extrude ()
    polygon (pts);
}

module part_pipe_fitting ()
{
  bom_ref ("Bowden compression fitting");
  
  d = 6;
  d2 = 8/cos(30);
  
  difference ()
  {
    union()
    {
      mock_thread (6, 4);
        
      translate ([0,0,4])
      {
        cylinder (d=d, h=5);
      
        translate ([0,0,1])
        cylinder (d=d2, h=3, $fn=6);
      
        translate ([0,0,5])
          mock_thread (6, 4);
        
        
        translate ([0,0,6])
        cylinder (d=d2, h=7, $fn=6);
      }
    }
    
    translate ([0,0,-1])
    cylinder (d=3, h=20);
  }
}


