// From Mendel90
//
// GNU GPL v2
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// Utilities
//

module rounded_square(w, h, r)
{
    union() {
        square([w - 2 * r, h], center = true);
        square([w, h - 2 * r], center = true);
        for(x = [-w/2 + r, w/2 - r])
            for(y = [-h/2 + r, h/2 - r])
                translate([x, y])
                    circle(r = r);
    }
}

module rounded_rectangle(size, r, center = true)
{
    w = size[0];
    h = size[1];
    linear_extrude(height = size[2], center = center)
        rounded_square(size[0], size[1], r);
}


//
// Cylinder with rounded ends
//
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
