// ============================================================================
// Module: rmc_shapes.scad   
// 
// Copyright (c) 2013 Bob Cousins
// 
// Description:  Useful shapes.
//
// ============================================================================

use <rmc_cuboids.scad>

// ****************************************************************************


function pythag_side (h,s) = sqrt (h*h - s*s);
function pythag_hypotenuse (s1,s2) = sqrt (s1*s1 + s2*s2);


//       y2
//      +--+
//     /    \
// z  /      \
//   +--------+
//       y1
//     
// extruded in X

module trapezoid (x, y1, y2, z)
{
  translate ([-x/2,0,-z/2])
  
  polyhedron (
    points=[ 
        [0, y1/2,0], 
        [0, y2/2,z],
        [0,-y2/2,z], 
        [0,-y1/2,0],
        [0,-y2/2,0],
        [0, y2/2,0],
        
        [x, -y1/2,0], 
        [x, -y2/2,z],
        [x, y2/2,z], 
        [x, y1/2,0],
        [x, y2/2,0],
        [x, -y2/2,0],
    ],
  
    faces = [
        [0,1,5], [5,1,2], [2,3,4], [4,5,2], 
        [3,2,7], [7,6,3],
        [1,8,2], [2,8,7],
        [9,8,1], [1,0,9],
        [3,6,9], [9,0,3],
        [6,7,11], [7,8,11], [8,10,11], [8,9,10]
    ]); 
}

// ****************************************************************************

/*
  spec is list of (x_width, y_offset)
  spec = [
    [5,0],
    [10,10]
  ];
*/
module prism_builder (spec, h)
{
  points_a = [
      for (p=[0:len(spec)-1])
        [spec[p][0]/2, spec[p][1]] ];
  points_b = [
      for (p=[len(spec)-1:-1:0])
        [-spec[p][0]/2, spec[p][1]] 
      ];
  points = concat (points_a, points_b);
      
  linear_extrude (h)  
    polygon (points);
}

// ****************************************************************************

//
//      +
// z   / \
//    /   \
//   +-----+
//      y
//
// A triangle extruded in X

module prism (x, y, z)
{
  translate ([0,0,-z/2])
  polyhedron (points=[[0,-y/2,0], [0,0,z], [0,y/2,0], [x,-y/2,0], [x,0,z], [x,y/2,0]],
    faces = [[2,1,0], [1,2,4], [2,5,4], [3,4,5], [0,1,4], [4,3,0], [5,2,0], [3,5,0]]); 
}


module prism_z (x, y, z, a)
{
  //translate ([0,0,-z/2])
  *polyhedron (
    points=[[0,-y/2,0], [x,0,0], [0,y/2,0], [x,-y/2,0], [x,0,z], [x,y/2,0]],
    faces = [[2,1,0], [1,2,4], [2,5,4], [3,4,5], [0,1,4], [4,3,0], [5,2,0], [3,5,0]]); 
  
  stitch (gen_triangle (x,y,a), gen_triangle (x,y,a), z);
}


function gen_rect (x,y) = [[x/2,y/2], [-x/2,y/2], [-x/2,-y/2], [x/2,-y/2]];

function gen_circle (r, fn=$fn) = [for (i=[0:fn-1]) [r*cos(i*360/fn), r*sin(i*360/fn)] ] ;

function gen_arc (r, a1, a2, fn=$fn) = [for (i=[a1:a2]) [r*cos(i*360/fn), r*sin(i*360/fn)] ] ;
  
function gen_triangle (x,y,a) = [
  [-x/2,0], [x/2,0], [-x/2+cos(a)*y, sin(a)*y]];


function gen_round_rect (x,y,r,fn=$fn) = [
  [x/2,y/2-r], 
  for (i=[0:360/fn:90]) [x/2-r + r*cos(i), y/2-r+r*sin(i)],
  [-x/2+r,y/2], 
  for (i=[90:360/fn:180]) [-x/2+r + r*cos(i), y/2-r+r*sin(i)],
  [-x/2,-y/2+r], 
  for (i=[180:360/fn:270]) [-x/2+r + r*cos(i), -y/2+r+r*sin(i)],
  [x/2-r,-y/2],
  for (i=[270:360/fn:360]) [x/2-r + r*cos(i), -y/2+r+r*sin(i)],
  ];


/*
  x,y    : base dimension
  x1, y1 : top dimension
  z      : height
  ang    : angle of side
*/
module truncated_pyramid (x, y, z, x1, y1, ang=90)
{
  
  x1 = (x1 == undef) ? x-z * cos(ang)*2 : x1;
  y1 = (y1 == undef) ? y-z * cos(ang)*2 : y1;
  
  /*
  polyhedron (points = 
    [[-x/2,y/2,0], [x/2,y/2,0], [x/2,-y/2,0], [-x/2,-y/2,0],
     [-x1/2,y1/2,z], [x1/2,y1/2,z], [x1/2,-y1/2,z], [-x1/2,-y1/2,z]],
  faces = [[3,2,1,0],
    [0,1,5,4],
    [2,6,5,1],
    [3,7,6,2],
    [0,4,7,3],
    [4,5,6,7]
  ]);
  */
  
  stitch (gen_rect (x,y), gen_rect(x1,y1), z);
}



module stitch (a, b, z)
{
  pts = [
    for (i=[0:len(a)-1]) [a[i][0], a[i][1], 0],
    for (i=[0:len(b)-1]) [b[i][0], b[i][1], z]
    ];
  
  
  if (len(a) > len(b))
     
    polyhedron (points=pts,
    faces = [
      [for (i=[0:len(a)-1]) i ],
        
      [for (i=[0:len(b)-1]) len(a) + len(b)-i-1 ],
  
        for (i=[0:len(a)-1]) 
          [i, 
            len(a) + len(b)/len(a) * i, 
            len(a) + (len(b)/len(a) * i+1)% len(b), 
          (i+1)%len(a)],
      ]
    );
  else
    polyhedron (points=pts,
    faces = [
      [for (i=[0:len(a)-1]) i ],
        
      [for (i=[0:len(b)-1]) len(a) + len(b)-i-1 ],
  
        for (i=[0:len(b)-1]) 
          [
             len(a) + i, 
             len(a) + (i+1)%len(b),
            (len(a)/len(b) * i+1)% len(a),
             len(a)/len(b) * i, 
          ]
    ]
  );
}

module rounded_truncated_pyramid (bottom_x, bottom_y, z, top_x, top_y,
    side_r = 2, 
    top_r = 0,
    draft=true)
{
  
  *%translate ([0, 0, z/2])
  cube ([top_x, top_y, z], center=true);
  
  if (draft)
  {
    //translate ([bottom_x/2, bottom_y/2, 0])
      truncated_pyramid (bottom_x, bottom_y, z, top_x, top_y);
  }
  else
  {
    ang_x = atan2 (z , (bottom_x-top_x)/2);
    ang_y = atan2 (z , (bottom_y-top_y)/2 );
    
    //echo(z=z);
    //echo (top_y=top_y);
    //echo (bottom_y=bottom_y);
    //echo((bottom_y-top_y)/2);

    p = (z-top_r*2)/z;
    
    //echo(ang_x=ang_x);
    //echo(ang_y=ang_y);
    
    offset_xx = top_r / sin(ang_x);
    offset_yy = top_r / sin(ang_y);
    
    offset_xz = top_r * cos(ang_x);

    //echo(offset_xx=offset_xx);
    //echo(offset_xz=offset_xz);
    
    //offset_y = bottom_r / sin(90-ang1);

    p2 = top_r + offset_xz;
    p3 = top_r - offset_xz;
    
    if (top_r > 0)
    {
      // top
      translate ([0,0, z-top_r])
      difference ()
      {
        round_box_type5b (
          top_x + (top_r-top_r/tan((180-ang_x)/2)) * 2, 
          top_y + (top_r-top_r/tan((180-ang_y)/2)) * 2, 
          top_r*2, top_r, center=true);

        translate ([0,0, -top_r + offset_xz])
          cube ([bottom_x+1, bottom_y+4, top_r+2], center=true);
      }

      //py = p2/tan(ang_y);
      
      pz = top_r + offset_xz;
    
      px = top_r/tan(ang_x/2) - top_r;
      py = top_r/tan(ang_y/2) - top_r;

      px2 = top_r/tan(ang_x/2) - top_r;
      
      *#translate ([0, bottom_y/2 - py,0])
      cube ([1, py, pz]);
    
      // bottom
      translate ([0, 0, top_r ])
      difference ()
      {
        round_box_type5a (
          bottom_x - px*2, 
          bottom_y - py*2, 
          top_r*2, top_r, center=true);
        
        translate ([0,0, top_r + offset_xz])
          cube ([bottom_x+1, bottom_y+4, top_r+2], center=true);
      }
    }
      
    translate ([0,0, p2])
    {
      stitch (
        gen_round_rect (
          bottom_x - p2/tan(ang_x) *2, 
          bottom_y - p2/tan(ang_y) *2, sin(ang_y)*side_r),
      
        gen_round_rect (
          top_x    + p3/tan(ang_x) *2, 
          top_y    + p3/tan(ang_y) *2, sin(ang_y)*side_r),
      
        z - p2-p3
      );
    }
    
  }
}


module open_box (outer_dimensions, wall)
{
  inner_dimensions = [ outer_dimensions[0] - wall*2, 
  outer_dimensions[1] - wall*2, 
  outer_dimensions[2]];
  
  difference ()
  {
    cube (outer_dimensions, center=true);
    
    translate ([0,0,wall])
    cube (inner_dimensions, center=true);
  }
    
  
}


// ****************************************************************************

module demo()
{
  
  // fir tree type shape
  spec = [
    [3,0],
    [3,2],
    [12,2],
    [5,6],
    [10,6],
    [3,10],
    [8,10],
    [3,12],
    [0,14]

  ];

  // prism_builder (spec, 1);

  z =10;
  
  x2=10;
  y2=20;
  
  a=10;
  
  x1=x2 + z*tan(a)*2;
  y1=y2 + z*tan(a)*2;

  
  %truncated_pyramid (x1,y1,z,x2,y2);

  $fn=36;
  $fs=1;

  rounded_truncated_pyramid (x1,y1,z,x2,y2, draft=false,
    side_r=1, top_r=1);

  //polygon (gen_round_rect (30,30,2));
  //truncated_pyramid (30,20,10,ang=45);
  //stitch (gen_rect (20,20), gen_rect(10,10),10);
  //stitch (gen_rect (20,20), gen_circle(10),10);
  //stitch (gen_circle(10, 12), gen_rect (20,20), 10);
}

//demo();

//prism_z ( 3,4,5,90);

//open_box ([20,30,10], 1);

