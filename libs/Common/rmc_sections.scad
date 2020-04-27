module y_section (size = 150, at=0, reverse=false, length=0)
{
    difference ()
    {
        children();
      
        translate ([size/2 + at + (reverse ? -size : 0),0,0])
            cube ([size,size,size], center=true);
      
      if (length)
        translate ([-size/2 + at-length + (reverse ? -size : 0),0,0])
            cube ([size,size,size], center=true);
    }
}

module x_section (size = 150, at=0)
{
    difference ()
    {
        children();
        translate ([0,size/2 + at,0])
            cube ([size,size,size], center=true);
    }
}

module z_section (size = 150, at=0)
{
    difference ()
    {
        children();
        translate ([0,0,size/2 + at])
            cube ([size,size,size], center=true);
    }
}
