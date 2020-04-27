



// r0 = radius of torus
// r1 = radius of tube
module torus(r0, r1)
{
	rotate_extrude()
	    translate([r0, 0, 0])
	    circle(r = r1);
}

// r0 = major radius
// r1 = minor radius
module torus_seg_90(r0, r1)
{
  rx = r0*2 + r1*2;
  
  difference ()
  {  
  	rotate_extrude()
	    translate([r0, 0, 0])
	    circle(r = r1);
	    
    translate ([-rx/2, 0, 0])
      cube ([rx, rx, r1*2], center=true);
        
    rotate ([0,0,90])
      translate ([-rx/2, -rx/2, 0])
        cube ([rx, rx+1, r1*2], center=true);
  }
}

// works for ang = 0 to 270
module torus_seg_ang(r0, r1, ang)
{
  rx = r0*2 + r1*2;
  
  difference ()
  {  
  	rotate_extrude()
	    translate([r0, 0, 0])
	    circle(r = r1);
	    
	  if (ang < 180)
	  {
      translate ([0, -rx/2, 0])
        cube ([rx+1, rx, r1*2+1], center=true);
          
      rotate ([0, 0, ang-180])
        translate ([0, -rx/2, 0])
          cube ([rx, rx, r1*2+1], center=true);
    }
    else
    {
      translate ([rx/2, -rx/2, 0])
        cube ([rx, rx, r1*2+1], center=true);
          
      rotate ([0, 0, ang-270])
        translate ([rx/2, -rx/2, 0])
          cube ([rx, rx, r1*2+1], center=true);
    }
  }
}
