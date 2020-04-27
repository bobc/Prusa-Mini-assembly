// Copyright 2010 D1plo1d

// This library is dual licensed under the GPL 3.0 and the GNU Lesser General Public License as per http://creativecommons.org/licenses/LGPL/2.1/ .

//testNutsAndBolts();

module testNutsAndBolts()
{
  p = -1;
  
	$fn = 360;
	translate([0,15]) 
    nutHole(3, proj=p);
  
	boltHole(3, length= 30, proj=p);
}

MM = "mm";
INCH = "inch"; //Not yet supported

//Based on: http://www.roymech.co.uk/Useful_Tables/Screws/Hex_Screws.htm
// width across corners
METRIC_NUT_AC_WIDTHS =
[
	-1, //0 index is not used but reduces computation
	-1,
	4.38,//m2
	6.40,  //m3
	8.10,  //m4
	9.20,  //m5
	11.50, //m6
	-1,
	15.00, //m8
	-1,
	19.60, //m10
	-1,
	22.10, //m12
	-1,
	-1,
	-1,
	27.70,//m16
	-1,
	-1,
	-1,
	34.60,//m20
	-1,
	-1,
	-1,
	41.60,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	53.1,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	63.5//m36
];

METRIC_NUT_THICKNESS =
[
	-1, //0 index is not used but reduces computation
	-1,
	1.6,//m2
	2.40,  //m3
	3.20,  //m4
	4.00,  //m5
	5.00,  //m6
	-1,
	6.50,  //m8
	-1,
	8.00,  //m10
	-1,
	10.00, //m12
	-1,
	-1,
	-1,
	13.00,//m16
	-1,
	-1,
	-1,
	16.00//m20
	-1,
	-1,
	-1,
	19.00,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	24.00,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	29.00//m36
];

COARSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS =
[//based on max values
	-1, //0 index is not used but reduces computation
	-1,
	1.6,//m2
	2.98,  //m3
	3.978, //m4
	4.976, //m5
	5.974, //m6
	-1,
	7.972,//m8
	-1,
	9.968,//m10
	-1,
	11.966,//m12
	-1,
	-1,
	-1,
	15.962,//m16
	-1,
	-1,
	-1,
	19.958,//m20
	-1,
	-1,
	-1,
	23.952,//m24
	-1,
	-1,
	-1,
	-1,
	-1,
	29.947,//m30
	-1,
	-1,
	-1,
	-1,
	-1,
	35.940//m36
];

// socket_size [J]
// head height [H]
// head_diam   [A]
// socket len  [K]
 
index_socket_size_J = 0; // size of hex driver 
index_head_height_H = 1; // height of cap head
index_head_diam_A   = 2; // diameter of cap head
index_socket_len_K  = 3; // depth of hex socket

METRIC_CAP_SCREW_SIZES =
[
	[-1, -1],    //0 index is not used but reduces computation
	[-1, -1],
	[1.5, 2, 3.8,  1],    //M2
	[2.5, 3, 5.5,  1.3],  //m3
	[3,   4, 7.0,  2.0],  //m4
	[4,   5, 8.5,  2.7],  //m5
	[5,   6,  10,  3.3],  //m6
	[-1, -1],
	[6,   8,  13,  4.3],  //m8
	[-1,  -1],
	[8,  10,  16,  5],    //m10
	[-1,  -1],
	[10, 12,  18,  6],    //m12
	[-1,  -1],
	[-1,  -1],    // M14
	[-1,  -1],
	[14.0, -1],   //m16
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[17.0, -1],   //m20
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[19.0, -1],   //m24
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],    //m30
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1],
	[-1,  -1]     //m36
];


module nutHole(size, units=MM, tolerance = +0.0001, proj = -1)
{
	//takes a metric screw/nut size and looks up nut dimensions
  
	radius = METRIC_NUT_AC_WIDTHS[size]/2+tolerance;
	height = METRIC_NUT_THICKNESS[size]+tolerance;
  
	if (proj == -1)
	{
		cylinder(r= radius, h=height, $fn = 6, center=[0,0]);
	}
  
	else if (proj == 1)
	{
		circle(r= radius, $fn = 6);
	}
  
	else if (proj == 2)
	{
		translate([-radius/2, 0])
			square([radius*2, height]);
	}
}

module boltHole(size, units=MM, length, tolerance = +0.0001, proj = -1)
{
	radius = COARSE_METRIC_BOLT_MAJOR_THREAD_DIAMETERS[size]/2+tolerance;
  
//TODO: proper screw cap values
	capHeight = METRIC_CAP_SCREW_SIZES[size][index_head_height_H]+tolerance;
	capRadius = METRIC_CAP_SCREW_SIZES[size][index_head_diam_A]/2+tolerance;

	if (proj == -1)
	{
	  translate([0, 0, -capHeight])
		  cylinder(r= capRadius, h=capHeight);
	  cylinder(r = radius, h = length);
	}
  
	else if (proj == 1)
	{
		circle(r = radius);
	}
  
	else if (proj == 2)
	{
		translate([-capRadius/2, -capHeight])
			square([capRadius*2, capHeight]);
		square([radius*2, length]);
	}
}
