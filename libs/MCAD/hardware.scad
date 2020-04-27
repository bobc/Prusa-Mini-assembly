// License: LGPL 2.1



bearingsize = 10;	// outer diameter of bearings in mm
bearingwidth = 4;	// width of bearings in mm

function screw_pitch(screwsize)  = screwsize / 6;
function nut_size(screwsize)     = 0.8 * screwsize;
function nut_diameter(screwsize) = 1.9 * screwsize;
function washer_size(screwsize)  = 0.2 * screwsize;
function washer_diameter(screwsize) = 2 * screwsize;

//partthick = 2 * rodsize;
//vertexrodspace = 2 * rodsize;
//c = [0.3, 0.3, 0.3];
//rodendoffset = rodnutsize + rodwashersize * 2 + partthick / 2;
//vertexoffset = vertexrodspace + rodendoffset;


render_rod_threads   = true;
render_screw_threads = false;
fn = 36;



module mcad_rod (rodsize, length, threaded=false) 
{
  $fs = 1;
  $fn = 24;
  $fa = 16;
  
  if (threaded && render_rod_threads) 
  {
    linear_extrude (height = length, center = true, convexity = 10, 
      twist = -360 * length / screw_pitch(rodsize), $fn=0, $fs=0.5)
      translate([rodsize * 0.1 / 2, 0, 0])
        circle(r = rodsize * 0.9 / 2);
  } 
  else 
    cylinder(h = length, r = rodsize / 2, center = true, $fn = fn);
}

module screw(screwsize=3, length, nutpos=0, washer=false, bearingpos = -1) 
{
  union()
  {
    // threaded part
    translate([0, 0, -length / 2]) 
      if (render_screw_threads) 
      {
        linear_extrude(height = length, center = true, convexity = 10, 
          twist = -360 * length / screwpitch(screwsize), $fn = fn)
        translate([screwsize * 0.1 / 2, 0, 0])
          circle(r = screwsize * 0.9 / 2, $fn = fn);
      } 
      else 
        cylinder(h = length, r = screwsize / 2, center = true, $fn = fn);
    
    // bolt head  
    difference() 
    {
      translate([0, 0, screwsize / 2]) cylinder(h = screwsize, r = screwsize, center = true, $fn = fn);
      translate([0, 0, screwsize]) cylinder(h = screwsize, r = screwsize / 2, center = true, $fn = 6);
    }
    
    if (washer && nutpos > 0) 
    {
      washer(screwsize, nutpos);
      nut(screwsize, nutpos + washer_size(screwsize));
    } 
    else if (nutpos > 0) 
      nut(screwsize, nutpos);
    
    if (bearingpos >= 0) 
       bearing(screwsize, bearingpos);
  }
}


module bearing (screwsize=3, position=0, bearing_od=bearingsize, bearing_w=bearingwidth) 
{
  translate([0, 0, -position - bearing_w / 2]) 
  union() 
  {
    difference() {
      cylinder(h = bearing_w, r = bearing_od / 2, center = true, $fn = fn);
      cylinder(h = bearing_w * 2, r = bearing_od / 2 - 1, center = true, $fn = fn);
    }
    difference() {
      cylinder(h = bearing_w - 0.5, r = bearing_od / 2 - 0.5, center = true, $fn = fn);
      cylinder(h = bearing_w * 2, r = screwsize / 2 + 0.5, center = true, $fn = fn);
    }
    difference() {
      cylinder(h = bearing_w, r = screwsize / 2 + 1, center = true, $fn = fn);
      cylinder(h = bearing_w + 0.1, r = screwsize / 2, center = true, $fn = fn);
    }
  }
}

module nut (screwsize=3, position=0, washer=0) 
{
  translate([0, 0, -position - nut_size(screwsize) / 2]) 
  {
    intersection() 
    {
      scale([1, 1, 0.5]) sphere(r = 1.05 * screwsize);
      difference() 
      {
        cylinder (h = nut_size(screwsize), r = nut_diameter(screwsize) / 2, center = true, $fn = 6);
        cylinder (r = screwsize / 2, h = nut_size(screwsize) + 0.1, center = true, $fn = fn);
      }
    }
    
    if (washer) washer(screwsize, 0);
  }
}

module rodnut(size, position=0, washer=0) 
{  
  translate([0, 0, position]) 
  {
    intersection() 
    {
      scale([1, 1, 0.5]) sphere(r = 1.05 * size);
      difference() 
      {
        cylinder (h = nut_size(size), r = nut_diameter(size) / 2, center = true, $fn = 6);
        
        mcad_rod(size, nut_size(size) + 0.1);
      }
    }
    
    if (washer == 1 || washer == 4) 
      rodwasher(size, ((position > 0) ? -1 : 1) * (nut_size(size) + washer_size(size)) / 2);
    
    if (washer == 2 || washer == 4) 
      rodwasher(size, ((position > 0) ? 1 : -1) * (nut_size(size) + washer_size(size)) / 2);
  }
}


module washer(screwsize=3, position=0) 
{
  translate ([0, 0, -position - washer_size(screwsize) / 2]) 
  difference() 
  {
    cylinder(r = washer_diameter(screwsize) / 2, h = washer_size(screwsize), center = true, $fn = fn);
    cylinder(r = screwsize / 2, h = washer_size(screwsize) + 0.1, center = true, $fn = fn);
  }
}

module rodwasher(size, position=0) 
{
  translate ([0, 0, position]) 
  difference() 
  {
    cylinder(r = washer_diameter(size) / 2, h = washer_size(size), center = true, $fn = fn);

    mcad_rod(size, washer_size(size) + 0.1);
  }
}

module caption (s, p=0)
{
  translate ([p+2.5, 10, 0])
  rotate ([0,0,90])
  text (s, size=5);
}

module demo ()
{
  rodsize = 6;
  
  p = rodsize * 2;
    
  caption ("rod");
  mcad_rod(rodsize, 20);
    
  translate([rodsize * 2.5, 0, 0]) 
  {
    caption ("rod (threaded=true)");
    mcad_rod(rodsize, 20, true);
  }
    
  translate([rodsize * 5, 0, 0])   
  {
    caption ("screw");
    screw(3, 10);
  }
  
  translate([rodsize * 5, -p, 0])  
  {
    rotate ([0,0,-90])
    caption ("screw (nut)");
    screw(3, 10, 5);
  }
  
  translate([rodsize * 5, -p*2, 0])  
  {
    rotate ([0,0,-90])
    caption ("screw (nut, washer)");
    screw(3, 10, 5, 1);
  }
  
  translate([rodsize * 5, -p*3, 0])  
  {
    rotate ([0,0,-90])
    caption ("screw (nut, washer, bearing)");
    screw(3, 10, 5, 1, 0);
  }

  translate([rodsize * 7.5, 0, 0])  
  {
    caption ("bearing");
    bearing(3);
  }
    
  translate([rodsize * 10, 0, 0])  
  {
    caption ("rodnut");
    rodnut(rodsize);
  }  
  
  translate([rodsize * 12.5, 0, 0])   
  {
    caption ("rodwasher");
    rodwasher(rodsize);
  }
    
  translate([rodsize * 15, 0, 0])    
  {
     caption ("nut");
     nut();
  }
  
  translate([rodsize * 17.5, 0, 0])   
  {
    caption ("washer");
    washer();
  }
}

demo();