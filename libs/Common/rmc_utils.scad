//******************************************************************************
// Description:
// 
// Utility functions
//
// Copyright CC-BY-SA Bob Cousins 2020
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************



module rotate_at (vec, rot)
{
  translate (vec)
    rotate (rot)
    translate ([-vec[0], -vec[1], -vec[2]])
      children();
}