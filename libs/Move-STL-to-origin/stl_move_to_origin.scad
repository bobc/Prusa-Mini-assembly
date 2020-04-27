

NE=1;
NW=2;
SW=3;
SE=4;
CENTER=5;

IDX_STL_NAME = 0;
IDX_DIMENSION = 1;
IDX_POSITION = 2;

DIM_X = 0;
DIM_Y = 1;
DIM_Z = 2;

/*
 NW      |    NE
         |
----- CENTER -----
         |
 SW      |    SE

*/



module move_stl_to_origin (spec, path = "", where = NE)
{
  if (where == NE) {
    objNE (spec, path);
  }
  else if (where == NW)
  {
    translate([ -spec[1][0], 0, 0 ])
      objNE (spec, path);
  }
  else if (where == SW) {
    translate([ -spec[1][0], -spec[1][1] , 0 ])
      objNE (spec, path);
  }
  else if (where == SE) {
    translate([ 0, -spec[1][1], 0])
      objNE (spec, path);
  }
  else if (where == CENTER)
  {
    translate([ -spec[1][0]/2 , -spec[1][1]/2 , -spec[1][2]/2 ])
      objNE (spec, path);
  }
}

module objNE (spec, path)
{
  translate([-spec[2][0], -spec[2][1], -spec[2][2] ])
    import(str(path, spec[0]));
}