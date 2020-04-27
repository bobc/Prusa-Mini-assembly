/*
 *  OpenSCAD Metric Fastners Library (www.openscad.org)
 *  Copyright (C) 2010-2011  Giles Bathgate
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License,
 *  LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
*/

include <nuts_and_bolts.scad>

//$fn=50;

apply_chamfer = false;

function af_to_diam(x) = x / cos(30);

module cap_bolt(dia, len)
{
	A = METRIC_CAP_SCREW_SIZES[dia][2];
	H = METRIC_CAP_SCREW_SIZES[dia][1];
  
	J = METRIC_CAP_SCREW_SIZES[dia][0];
	K = METRIC_CAP_SCREW_SIZES[dia][3];

  // thread
	cylinder(r=dia/2,h=len);
  
  // head
  difference ()
  {
    translate([0,0,-H]) cylinder(r=A/2, h=H);
    
    translate([0,0,-H-0.01])
      cylinder(r=J/2/cos(30), h=K, $fn=6);
  }
}

module cap_bolt_plus (diam, len, washer=false, 
  nut_pos=0, nut_style=0)
{
  cap_bolt (diam, len);
  
  washer_size = 0.2 * diam;
  
  if (washer)
    translate ([0,0,nut_pos])
    washer(diam);
  
  offset = washer ? washer_size : 0;
  
  if (nut_pos > 0) 
  {
    translate ([0,0, nut_pos + offset])
    if (nut_style == 0)
      flat_nut (diam);
    else if (nut_style == 1)
      square_nut (diam);
    else if (nut_style == 2)
      nyloc_nut (diam);
  } 

}


module button_head_bolt(dia,len)
{
	//A = METRIC_CAP_SCREW_SIZES[dia][2];
	//H = METRIC_CAP_SCREW_SIZES[dia][1];
  
  A = dia * 1.8;
  H = dia * 0.52;
  
	J = METRIC_CAP_SCREW_SIZES[dia][0];
	K = METRIC_CAP_SCREW_SIZES[dia][3];

  // thread
	cylinder(r=dia/2, h=len);
  
  // head
  difference ()
  {
    translate([0,0,-H]) cylinder(r=A/2, h=H);
    
    translate([0,0,-H-0.01])
      cylinder(r=J/2/cos(30), h=K, $fn=6);
  }
}

module csk_bolt(dia, len)
{
	h1=0.6*dia;
  
	h2=len-h1;
  
	cylinder(r=dia/2,h=len);
  
	cylinder(r1=dia,r2=dia/2,h=h1);
}

module washer(dia)
{
	t = 0.2*dia;
  
	difference()
	{
		cylinder(r=dia, h=t);
		translate([0,0,-t/2]) cylinder(r=dia/2,h=t*2);
	}
}

module flat_nut(dia, tolerance = +0.0001)
{
	c=0.2*dia;
  
	radius = METRIC_NUT_AC_WIDTHS[dia]/2 + tolerance;
	height = METRIC_NUT_THICKNESS[dia]   + tolerance;
  
	difference()
	{
		cylinder(r=radius, h=height, $fn=6);
    
		translate([0,0,-height/2]) cylinder(r=dia/2, h=height*2);
    
		if(apply_chamfer)
		    translate([0,0,c]) cylinder_chamfer(radius, c);
	}
}


module square_nut (diam)
{
  square_nut_dimension = [
  // D,	   S max,  	S min,	  S nom,	  e,	      m max
  // 0     1        2         3         4         5
    [1.6	,3.2000,	2.9000,	  3.0500,	  3.9650,	  1.0000],
    [2	  ,4.0000,	3.7000,	  3.8500,	  5.0050,	  1.2000],
    [2.5	,5.0000,	4.7000,	  4.8500,	  6.3050,	  1.6000],
    [3	  ,5.5000,	5.2000,	  5.3500,	  6.9550,	  1.8000],
    [3.5	,6.0000,	5.7000,	  5.8500,	  7.6050,	  2.0000],
    [4	  ,7.0000,	6.6400,	  6.8200,	  8.8660,	  2.2000],
    [5	  ,8.0000,	7.6400,	  7.8200,	  10.1660,	2.7000],
    [6	  ,10.0000,	9.6400,	  9.8200,	  12.7660,	3.2000],
    [8	  ,13.0000,	12.5700,	12.7850,	16.6205,	4.0000],
    [10	  ,17.0000,	16.5700,	16.7850,	21.8205,	5.0000]
  ];

  index = search (diam, square_nut_dimension);
  entry = square_nut_dimension[index[0]];
  
  if (entry ==undef)
  {
    echo (str("ERROR: unknown size ", diam));
  }
  
  translate ([0,0,entry[5]/2])
  difference ()
  {
    cube ([entry[3], entry[3], entry[5]], center=true);
    cylinder (d=diam, h=entry[5]+1, center=true); 
  }

}

// From Mendel90, nuts.scad
M2p5_nut  = [2.5, 5.8, 2.2, 3.8];
M3_nut      = [3, 6.4, 2.4, 4];
M4_nut      = [4, 8.1, 3.2, 5];
M5_nut      = [5, 9.2,   4, 6.25];
M6_nut      = [6, 11.5,  5, 8];
M6_half_nut = [6, 11.5,  3, 8];
M8_nut      = [8, 15,  6.5, 8];

nut_list = [
  [2.5, M2p5_nut],
  [3, M3_nut],
  [4, M4_nut],
  [5, M5_nut],
  [6, M6_nut],
  [8, M8_nut]
];

function nut_radius(type) = type[1] / 2;
function nut_flat_radius(type) = nut_radius(type) * cos(30);
function nut_thickness(type, nyloc = false) = nyloc ? type[3] : type[2];
function nut_washer(type) = type[4];
function nut_trap_depth(type) = type[5];

module nyloc_nut(diam, nyloc = true) 
{
  module rounded_cylinder(r, h, r2)
  {
    rotate_extrude()
        union() {
            square([r - r2, h]);
            square([r, h - r2]);
            translate([r - r2, h - r2])
                circle(r = r2);
        }
  }  

  eta = 0.01;
  
  index = search (diam, nut_list);
  type = nut_list [index[0]][1];
  
  hole_rad  = type[0] / 2;
  outer_rad = nut_radius(type);
  thickness = nut_thickness(type);
  nyloc_thickness = type[3];

/*
  if(nyloc)
    vitamin(str("NYLOCM", type[0], ": Nyloc nut M", type[0]));
  else if(brass)
    vitamin(str("NUTBM", type[0], ": Brass nut M", type[0]));
  else
    vitamin(str("NUTM", type[0], ": Nut M", type[0]));

  if(exploded && nyloc)
    cylinder(r = 0.2, h = 10);
*/
  
  //color (brass ? brass_nut_color : nut_color) 
  color("silver")
  render() 
  difference() 
  {
    union() 
    {
      cylinder(r = outer_rad, h = thickness, $fn = 6);
      
      if (nyloc)
        translate([0,0, eta])
        rounded_cylinder(r = outer_rad * cos(30), 
          h = nyloc_thickness, r2 = (nyloc_thickness - thickness) / 2, $fs=0.5);
      }
      translate([0, 0, -1])
        cylinder(r = hole_rad, h = nyloc_thickness + 2, $fs=0.5);
  }
}



module bolt(dia, len, tolerance = +0.0001)
{
	c=0.2*dia;

 	radius = METRIC_NUT_AC_WIDTHS[dia]/2 + tolerance;
	height = METRIC_NUT_THICKNESS[dia]   + tolerance;

  translate([0,0,-height]) 
	difference()
	{
		cylinder(r=radius, h=height, $fn=6);
    
		if(apply_chamfer)
		    translate([0,0,c]) cylinder_chamfer(radius, c);
	}

	cylinder(r=dia/2, h=len);
}

module cylinder_chamfer(r1,r2)
{
	t=r1-r2;
	p=r2*2;
	rotate_extrude()
	difference()
	{
		translate([t,-p])square([p,p]);
		translate([t,0])circle(r2);
	}
}

module chamfer(len,r)
{
	p=r*2;
	linear_extrude(height=len)
	difference()
	{
		square([p,p]);
		circle(r);
	}
}

module caption (s, p)
{
  translate ([p+2.5, 10, 0])
  rotate ([0,0,90])
  text (s, size=5);
}

union()
{
  $fn=0;
  $fa=0.01;
  $fs=0.25;

//  
  caption ("cylinder_chamfer", -20);
  translate ([-20,0,0])
    cylinder_chamfer(8,1);
  
  caption ("chamfer", -40);  
  translate ([-40,0,0])
    chamfer(14, 2);
//  
  caption ("csk_bolt", 0);
  csk_bolt(3, 14);
  
  caption ("washer", 10);
  translate ([10,0,0])
    washer(3);
  
  caption ("flat_nut", 20);
  translate ([20,0,0])
    flat_nut(3);
  
  caption ("bolt", 30);
  translate ([30,0,0])
    bolt(4, 14);

  caption ("cap_bolt", 40);
  translate ([40,0,0])
    cap_bolt(4, 14);

  caption ("button_head_bolt", 50);
  translate ([50,0,0])
    button_head_bolt(4, 14);

  caption ("square_nut", 60);
  translate ([60,0,0])
    square_nut (3);

  caption ("cap_bolt_plus", 70);
  translate ([70,0,0])
    cap_bolt_plus(4, 14);

  caption ("cap_bolt_plus", 80);
  translate ([80,0,0])
    cap_bolt_plus(4, 14, washer=false, nut_pos = 1, nut_style=2);
}
