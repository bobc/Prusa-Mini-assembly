//******************************************************************************
// Description:
// 
// Prusa Mini - BOM functions
//
// OpenSCAD code Copyright CC-BY-SA Bob Cousins 2020
//
// STL files from prusa3d/Original-Prusa-MINI licensed under the GNU General Public License v3.0 by Prusa Research a.s.
//
// Revision History:
//
// 1 2020-04-17 RMC  Initial version
//******************************************************************************


// requires include <../move-to-origin/stl_move_to_origin.scad>
// requires config.scad


//
module bom_assembly(name)
{
  echo (str("<b>bom, assembly, ",name));
  
  children();
  
  echo (str("<b>bom, /assembly, ",name));
}

module assembly_start(name)
{
  echo (str("<b>bom, assembly, ",name));
}

module assembly_end(name)
{
  echo (str("<b>bom, /assembly, ",name));
}

module bom_ref(name)
{
  echo (str("<b>bom, part, ",name));
  
  children();
}

module bom_printed (spec,path,where)
{
  echo (str("<b>bom, printed, ", spec[0]));

  move_stl_to_origin (spec, path=path, where=where);
}

module bom_mech (spec,path,where)
{
  echo (str("<b>bom, mech, ", spec[0]));

  move_stl_to_origin (spec, path=path, where=where);
}

// compatibility functions for Mendel90 files

// name a vitamin
module vitamin(name) 
{                  
  if (show_bom_level >= BOM_VITAMINS)
     echo(name);
}

