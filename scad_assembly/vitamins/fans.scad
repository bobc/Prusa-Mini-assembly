//
// Mendel90
//
// nop.head@gmail.com
// hydraraptor.blogspot.com

// based on http://www.thingiverse.com/thing:8063 by MiseryBot, CC license

include <../conf/config.scad>
//include <../vitamins/washers.scad>
//include <../vitamins/screws.scad>
use <../utils/Utilities.scad>

//          W   D   bore pitch screw          hub   thickness OD  
fan80x38 = [80, 38, 75, 35.75, 4, 40,   4.3, 84];
fan60x25 = [60, 25, 57, 25,    4, 31.5, 3.6, 64];
fan60x15 = [60, 15, 57, 25,    4, 29,   2.4, 60];
fan40x10 = [40, 10, 37, 16,    3, 20,   10, 100];
fan30x10 = [30, 10, 27, 12,    3, 17,   10, 100];
fan20x10 = [20, 10, 17, 8,     3, 12,   10, 100]; // not checked


function fan_width(type)          = type[0];
function fan_depth(type)          = type[1];
function fan_bore(type)           = type[2];
function fan_hole_pitch(type)     = type[3];
function fan_screw(type)          = type[4];
function fan_hub(type)            = type[5];

function fan_thickness(type)      = type[6];
function fan_outer_diameter(type) = type[7];

function screw_clearance_radius(d) = d * 1.067/2;


module fan(type) 
{
  width = fan_width(type);
  depth = fan_depth(type);
  thickness     = fan_thickness(type);
  hole_pitch    = fan_hole_pitch(type);
  corner_radius = width / 2 - hole_pitch;
  screw         = fan_screw(type);

  vitamin(str("FAN-", fan_width(type), "-", fan_depth(type), 
    ": Fan ", fan_width(type), "mm x ", fan_depth(type), "mm"));

  difference() 
  {
    linear_extrude(height = depth, center = true, convexity = 4)
    difference() 
    {
      //overall outside
      rounded_square (width, width, corner_radius);

      //main inside bore, less hub
      difference() {
          circle(r = fan_bore(type) / 2);
          circle(r = fan_hub(type) / 2);
      }

      //Mounting holes
      for(x = [-hole_pitch, hole_pitch])
          for(y = [-hole_pitch, hole_pitch])
              translate([x, y])
                  circle(r = screw_clearance_radius(screw));
    }

    //Remove outside ring
    difference() 
    {
      cylinder(r = sqrt(2) * width / 2, h = depth - 2 * thickness, center = true);
      cylinder(r = fan_outer_diameter(type) / 2, h = depth - 2 * thickness + 0.2, center = true);
    }
  }

  //Seven Blades
  linear_extrude(height = depth - 1, center = true, convexity = 4, twist = -30, slices = depth / 2)
    for(i= [0 : 6])
      rotate((360 * i) / 7)
      translate([0, -1.5 / 2])
      square([fan_bore(type) / 2 - 0.75, 1.5]);
}

module fan_hole_positions(type) {
    //Mounting holes
    hole_pitch = fan_hole_pitch(type);
    for(x = [-hole_pitch, hole_pitch])
        for(y = [-hole_pitch, hole_pitch])
            translate([x, y, fan_depth(type) / 2])
                children();
}

module fan_holes(type, poly = false) {
    //Mounting holes
    hole_pitch = fan_hole_pitch(type);
    screw = fan_screw(type);
    fan_hole_positions(type)
        if(poly)
            poly_cylinder(r = screw_clearance_radius(screw), h = 100, center = true);
        else
            cylinder(r = screw_clearance_radius(screw), h = 100, center = true);

    cylinder(r = fan_bore(type) / 2, h = 100, center = true);
}

module fan_assembly(type, thickness, include_fan = false) {
    if(include_fan)
        color(fan_color)
            render()
                fan(type);

    hole_pitch = fan_hole_pitch(type);
    screw = fan_screw(type);
    washer = screw_washer(screw);
    nut = screw_nut(screw);
    for(x = [-hole_pitch, hole_pitch])
        for(y = [-hole_pitch, hole_pitch]) {
            translate([x, y, thickness + fan_depth(type) / 2])
                screw_and_washer(screw, screw_longer_than(thickness + fan_thickness(type) +
                                 washer_thickness(washer) + nut_thickness(nut, true)));
            translate([x, y, fan_depth(type) / 2 - (include_fan ? fan_thickness(type) : 0)])
                rotate([180, 0, 0])
                    nut(screw_nut(screw), true);
        }
}

//fan(fan80x38);
//fan(fan60x25);

//fan(fan40x10);
