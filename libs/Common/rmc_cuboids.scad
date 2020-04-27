// ============================================================================
// Module: rmc_cuboids.scad   
//                                                           
// Copyright (c) 2010 Bob Cousins                                                    
//                                                                           
// Description:                                                             
//   Useful shapes.
//
//  plate with round edges on two opposite sides. Six orientations.
//
//    module round_plate_type2a (size_x, size_y, size_z, r)
//    module round_plate_type2b (size_x, size_y, size_z, r)
//    module round_plate_type2c (size_x, size_y, size_z, r)
//    module round_plate_type2d (size_x, size_y, size_z, r)
//    module round_plate_type2e (size_x, size_y, size_z, r)
//    module round_plate_type2f (size_x, size_y, size_z, r)
//
//  plate with round edges on four edges, different orientations
//    module round_plate_type3x (size_x, size_y, size_z, r)
//    module round_plate_type3y (size_x, size_y, size_z, r)
//    module round_plate_type3z (size_x, size_y, size_z, r)
//
//  box with rounded edges on four sides, different orientations
//
//    module round_box_type4a (size_x, size_y, size_z, r)
//    module round_box_type4b (size_x, size_y, size_z, r)
//    module round_box_type4c (size_x, size_y, size_z, r)
//
//  box with rounded edges 
//  type5a: on all sides, corners
//  type5b: on 5 sides, corners
//
//    module round_box_type5a (size_x, size_y, size_z, r)
//    module round_box_type5b (size_x, size_y, size_z, r)
//
// demos
//    module demo_plates_type2 ()
//    module demo_plates_type3 ()
//    module demo_box_type4 ()
//    module demo_box_type5 ()
// ============================================================================

//$fs=0.1;
//$fn=0;
//$fa=0.01;

demo = 3; // [0:5]

module sub_round_plate_type0 (size_x, size_y, size_z, r=3)
{
  in_x = size_x - r*2;
  in_y = size_y - r*2;
  
  union () 
  {
    // fill center
    translate ([-in_x/2 - r, -size_y/2, -size_z/2])
      cube ([in_x+r, size_y, size_z]);

    translate ([-size_x/2, -size_y/2, -size_z/2])
      cube ([size_x, size_y-r, size_z]);
    
    // round edges 
    translate ([in_x/2, in_y/2, 0])     cylinder (h=size_z, r=r, center=true);
  }
}

module round_plate_type0a (size_x, size_y, size_z, r=3, center=false)
{
  sub_round_plate_type0 (size_x, size_y, size_z, r);
}

module round_plate_type0b (size_x, size_y, size_z, r=3, center=false)
{
  rotate ([0,0,90])
  sub_round_plate_type0 (size_y, size_x, size_z, r);
}

module round_plate_type0c (size_x, size_y, size_z, r=3, center=false)
{
  rotate ([0,0,180])
  sub_round_plate_type0 (size_x, size_y, size_z, r);
}

module round_plate_type0d (size_x, size_y, size_z, r=3, center=false)
{
  rotate ([0,0,-90])
  sub_round_plate_type0 (size_y, size_x, size_z, r);
}



module sub_round_plate_type1a (size_x, size_y, size_z, r=3)
{
  in_x = size_x - r*2;
  in_y = size_y - r*2;
  
  union () 
  {
    // fill center
    translate ([-in_x/2 - r, -size_y/2, -size_z/2])
      cube ([in_x+r, size_y, size_z]);

    translate ([-size_x/2, -in_y/2, -size_z/2])
      cube ([size_x, in_y, size_z]);
    
    // round edges 
    translate ([in_x/2, in_y/2, 0])     cylinder (h=size_z, r=r, center=true);
    translate ([in_x/2, -in_y/2, 0])     cylinder (h=size_z, r=r, center=true);
  }
}

module round_plate_type1x (size_x, size_y, size_z, r, center=false)
{
  if (center == false)
  {
    translate ([size_x/2, size_y/2, size_z/2])
    	sub_round_plate_type1a (size_x, size_y, size_z, r);
  }
  else
  {
    sub_round_plate_type1a (size_x, size_y, size_z, r);
  }
}

module round_plate_type1y (size_x, size_y, size_z, r, center=false)
{
  if (center == false)
  {
    translate ([size_x/2, size_y/2, size_z/2])
      rotate ([0,0,90])
    	sub_round_plate_type1a (size_y, size_x, size_z, r);
  }
  else
  {
	rotate ([0,0,90])
        sub_round_plate_type1a (size_y, size_x, size_z, r);
  }
}

module round_plate_type1z (size_x, size_y, size_z, r, center=false)
{
  if (center == false)
  {
    translate ([size_x/2, size_y/2, size_z/2])
      rotate ([0,-90,0])
    	sub_round_plate_type1a (size_z, size_y, size_x, r);
  }
  else
  {
    rotate ([0,-90,0])
        sub_round_plate_type1a (size_z, size_y, size_x, r);
  }
}


// ****************************************************************************
// draw plate with round ends in x axis
// vert plane
module sub_round_plate_type2a (size_x, size_y, size_z, r=3, col="gold")
{
  in_x = size_x - r*2;
  in_y = size_y - r*2;
  
  union () 
  {
    // fill center
    translate ([-in_x/2, -size_y/2, -size_z/2])
    color (col)
    cube ([in_x, size_y, size_z]);

    translate ([-size_x/2, -in_y/2, -size_z/2])
    color (col)
    cube ([size_x, in_y, size_z]);
    
    // round edges 
    translate ([in_x/2, in_y/2, 0])   color (col)  cylinder (h=size_z, r=r, center=true);
    translate ([-in_x/2, in_y/2, 0])  color (col)   cylinder (h=size_z, r=r, center=true);
    translate ([in_x/2, -in_y/2, 0])  color (col)   cylinder (h=size_z, r=r, center=true);
    translate ([-in_x/2, -in_y/2, 0]) color (col)    cylinder (h=size_z, r=r, center=true);
  }
}

module round_plate_type2a (size_x, size_y, size_z, r, center=false, col="gold")
{
  if (center == false)
  {
    translate ([size_x/2, size_y/2, size_z/2])
    	sub_round_plate_type2a (size_x, size_y, size_z, r, col=col);
  }
  else
  {
    sub_round_plate_type2a (size_x, size_y, size_z, r, col=col);
  }
}

module round_plate_type2b (size_x, size_y, size_z, r, center=false)
{
  if (center == false)
  {
    translate ([size_x/2, size_y/2, size_z/2])
	rotate ([0,90,0])
  	round_plate_type2a (size_z, size_y, size_x, r, true);
  }
  else
  {
	rotate ([0,90,0])
  	round_plate_type2a (size_z, size_y, size_x, r, true);
  }
}

// vert other plane
module round_plate_type2c (size_x, size_y, size_z, r, center=false)
{
	if (center == false)
	{
		translate ([size_x/2, size_y/2, size_z/2])
  		rotate ([0,0,90])
  		round_plate_type2a (size_y, size_x, size_z, r, true);
	}
	else
	{ 
  		rotate ([0,0,90])
  		round_plate_type2a (size_y, size_x, size_z, r, true);
	}
	 
}

module round_plate_type2d (size_x, size_y, size_z, r, center=false)
{
	if (center == false)
	{
	    translate ([size_x/2, size_y/2, size_z/2] )
  			rotate ([0,90,90])
  			round_plate_type2a (size_z, size_x, size_y, r, true);
  	}
  	else
  	{
		rotate ([0,90,90])
  			round_plate_type2a (size_z, size_x, size_y, r, true);
  	}

}

// horiz
module round_plate_type2e (size_x, size_y, size_z, r, center=false)
{
	if (center == false)
	{
	    translate ([size_x/2, size_y/2, size_z/2] )
      rotate ([90,0,0])
  		round_plate_type2a (size_x, size_z, size_y, r, true);
  	}
  	else
  	{
      rotate ([90,0,0])
  		round_plate_type2a (size_x, size_z, size_y, r, true);
  	}
}

module round_plate_type2f (size_x, size_y, size_z, r, center=false)
{
	if (center == false)
	{
	    translate ([size_x/2, size_y/2, size_z/2] )
  		rotate ([90,0,90])
  		round_plate_type2a (size_y, size_z, size_x, r, true);
  }
  else
  {
      rotate ([90,0,90])
      round_plate_type2a (size_y, size_z, size_x, r, true);
  }
}


// ****************************************************************************

// draw cube with round edges in x,y,z axes

module round_plate_type3_center (size_x, size_y, size_z, r)
{
  in_x = size_x - r*2;
  in_y = size_y - r*2;
  in_z = size_z - r*2;
  
  hull()
  {  
    // corner spheres
    translate ([-in_x/2, in_y/2, in_z/2])     sphere (r=r);
    translate ([-in_x/2, -in_y/2, in_z/2])     sphere (r=r);
    
    translate ([in_x/2, in_y/2, in_z/2])     sphere (r=r);
    translate ([in_x/2, -in_y/2, in_z/2])     sphere (r=r);
    
    translate ([-in_x/2, in_y/2, -in_z/2])     sphere (r=r);
    translate ([-in_x/2, -in_y/2, -in_z/2])     sphere (r=r);
    
    translate ([in_x/2, in_y/2, -in_z/2])     sphere (r=r);
    translate ([in_x/2, -in_y/2, -in_z/2])     sphere (r=r);
  }
  
}

module round_plate_type3 (size_x, size_y, size_z, r, center=true)
{
	if (center == false)
	{
    translate ([size_x/2, size_y/2, size_z/2] )
      round_plate_type3_center (size_x, size_y, size_z, r);
	}
	else
	{
		round_plate_type3_center (size_x, size_y, size_z, r);
	}
}

// ****************************************************************************

// now same as plate type 2
// composite
module round_box_type4a (size_x, size_y, size_z, r, center=true, col="gold")
{
  round_plate_type2a (size_x, size_y, size_z, r, center, col=col);
}

module round_box_type4b (size_x, size_y, size_z, r, center=true)
{
	if (center == false)
	{
	    translate ([0, size_y, 0] )
	    rotate ([90,0,0])
    	round_box_type4a (size_x, size_z, size_y, r, center);
  	}
  	else
  	{
    rotate ([90,0,0])
    	round_box_type4a (size_x, size_z, size_y, r, center);
  	}
}

module round_box_type4c (size_x, size_y, size_z, r, center=true)
{
	if (center == false)
	{
	    translate ([0,0,size_z] )
	    rotate ([0,90,0])
    	round_box_type4a (size_z, size_y, size_x, r, center);
  	}
  	else
  	{
    rotate ([0,90,0])
    	round_box_type4a (size_z, size_y, size_x, r, center);
  	}
}

// ****************************************************************************

// same as plate type3

// fully rounded corners
module round_box_type5a (size_x, size_y, size_z, r, center=false)
{
  // fully rounded ends
  round_plate_type3 (size_x, size_y, size_z, r, center);
}

// rounded top, sides
module round_box_type5b (size_x, size_y, size_z, r, center=false)
{
  in_x = size_x - r*2;
  in_y = size_y - r*2;
  in_z = size_z - r;
  
  cx = in_x/2;
  cy = in_y/2;
  
  if (center==false)
  {
  	translate ([size_x/2, size_y/2, size_z/2])
	  union () 
	  {
      //debug: reference cube
      *#translate ([-size_x/2, -size_y/2, -size_z/2])
        cube ([size_x, size_y, size_z]);

      // round top
      translate ([0, 0, 0])          
        round_plate_type3 (size_x, size_y, size_z, r, true);
      
      // fill center
      if (in_z>0)
        translate ([0, 0, -r/2])       
        round_box_type4a (size_x, size_y, in_z, r, true);
	  }
  }
  else
  {
	  union () 
	  {
      //debug: reference cube
      *#translate ([-size_x/2, -size_y/2, -size_z/2])
        cube ([size_x, size_y, size_z]);
	
	    if (r != 0)
	    {
	      // round top
	      translate ([0, 0, 0])          
          round_plate_type3 (size_x, size_y, size_z, r, center);
	      
        if (in_z>0)
          // fill center
          translate ([0, 0, -r/2])       
          round_box_type4a (size_x, size_y, in_z, r, center);
      }
      else
        translate ([-size_x/2, -size_y/2, -size_z/2])
          cube ([size_x, size_y, size_z]);
	  }
  }
}

module round_box_type5c (size_x, size_y, size_z, r, center=false)
{
  if (center==false)
    translate ([0, size_y, size_z])
    rotate ([180,0,0])
      round_box_type5b (size_x, size_y, size_z, r, center);
  else
    translate ([0, 0, 0])
    rotate ([180,0,0])
      round_box_type5b (size_x, size_y, size_z, r, center);
}


//
//
//
module square_tube (len, width, wall)
{
    inner = width - wall*2;
    difference ()
    {
        cube ([width,width,len], center=true);
        
        cube ([inner,inner,len+1], center=true);
    }
}

module rect_tube (len, width, height, wall)
{
    inner = width - wall*2;
    difference ()
    {
        cube ([width,height,len], center=true);
        
        cube ([inner,height-wall*2,len+1], center=true);
    }
}

// ****************************************************************************
// demo modules
// ****************************************************************************

module demo_type0 ()
{
	c = true;
	
    translate ([0,40,0])    sub_round_plate_type0 (80, 20, 5, 5);
    translate ([50,40,0])    text ("sub_round_plate_type0",valign="center");

    translate ([0,80,0])    round_plate_type0a (80, 20, 5, 5, c);
    translate ([50,80,0])    text ("round_plate_type0a",valign="center");
    
    translate ([0,120,0])   round_plate_type0b (80, 20, 5, 5, c);
    translate ([50,120,0])   text ("round_plate_type0b",valign="center");
  
    translate ([0,160,0])   round_plate_type0c (80, 20, 5, 5, c);
    translate ([50,160,0])   text ("round_plate_type0c",valign="center");

    translate ([0,200,0])   round_plate_type0d (80, 20, 5, 5, c);
    translate ([50,200,0])   text ("round_plate_type0d",valign="center");
  
}

module demo_type1 ()
{
	c = true;
	
    translate ([0,40,0])    
    {
      sub_round_plate_type1a (80, 20, 40, 5);
      translate ([50,0,0])
      text ("sub_round_plate_type1a",valign="center");
    }

    translate ([0,80,0])    
    {
      round_plate_type1x (80, 20, 40, 5, c);
      translate ([50,0,0])
      text ("round_plate_type1x",valign="center");
    }
    
    translate ([0,120,0])   
    {
      round_plate_type1y (80, 20, 40, 5, c);
      translate ([50,0,0])
      text ("round_plate_type1y",valign="center");
    }
  
    translate ([0,160,0])
    {
      round_plate_type1z (80, 20, 40, 5, c);
      translate ([50,0,0])
      text ("round_plate_type1z",valign="center");
    }

}


module demo_plates_type2 ()
{
	c = true;
	
	color ("red")
    translate ([0,00,0])    round_plate_type2a (80, 20, 40, 5, c);
    translate ([50,0,0])    text ("round_plate_type2a",valign="center");
    
	color ("green")
    translate ([0,40,0])    round_plate_type2b (80, 20, 40, 5, c);
    translate ([50,40,0])    text ("round_plate_type2b",valign="center");
    
    translate ([0,110,0])    round_plate_type2c (20, 80, 40, 5, c);
    translate ([50,110,0])    text ("round_plate_type2c",valign="center");
   
    translate ([0,200,0])   round_plate_type2d (20, 80, 40, 5, c);
    translate ([50,200,0])    text ("round_plate_type2d",valign="center");
    
    translate ([0,270,0])    round_plate_type2e (80, 40, 20, 5, c);
    translate ([50,270,0])    text ("round_plate_type2e",valign="center");
    
    translate ([0,320,0])    round_plate_type2f (80, 40, 20, 5, c);    
    translate ([50,320,0])    text ("round_plate_type2e",valign="center");
}

module demo_plates_type3 ()
{
	c = false;
	
	color ("red")
    translate ([0,0,0])     round_plate_type3 (20, 80, 40, 5, c);
    translate ([90,40,0])   text ("round_plate_type3",valign="center");

    
	color ("green")
    translate ([0,90,0])    round_plate_type3 (80, 20, 40, 5, c);
    translate ([90,100,0])   text ("round_plate_type3",valign="center");

	color ("blue")
    translate ([0,120,0])    round_plate_type3 (80, 40, 20, 5, c);
    translate ([90,140,0])   text ("round_plate_type3",valign="center");

}

module demo_box_type4 ()
{
	c = false;
	
	color ("blue")
    translate ([0,0,60])
    round_box_type4a (50, 30, 20, 5, c);
    
	color ("green")
    translate ([0,60,0])
    round_box_type4b (50, 30, 20, 5, c);
    
	color ("red")
    translate ([60,0,0])
    round_box_type4c (50, 30, 20, 5, c);
}

module demo_box_type5 ()
{
	c = false;
	
	color ("pink")
      round_box_type5a (40, 30, 20, 5, c);
  
  translate ([50,10,0])    text ("round_box_type5a",valign="center");


    
	color ("lime")
    translate ([0,40,0])
  {
      round_box_type5b (40, 30, 20, 5, c);
    
      translate ([50,10,0])    text ("round_box_type5b",valign="center");
  }
      
	color ("aqua")
    translate ([0,80,0])
    {
      round_box_type5c (40, 30, 20, 5, c);
      translate ([50,10,0])    text ("round_box_type5c",valign="center");
    }
}

// ****************************************************************************

// 2 and 4 are basically the same

if (demo==0) demo_type0();
else if (demo==1) demo_type1();
else if (demo==2) demo_plates_type2();
else if (demo==3) demo_plates_type3();
else if (demo==4) demo_box_type4();
else if (demo==5) demo_box_type5();


