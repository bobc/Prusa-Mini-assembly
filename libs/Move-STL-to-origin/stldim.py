#
#
#
# Dependencies : stl numpy



import math
import stl
from stl import mesh
import numpy

import os
import sys


# this stolen from numpy-stl documentation
# https://pypi.python.org/pypi/numpy-stl

# find the max dimensions, so we can know the bounding box, getting the height,
# width, length (because these are the step size)...
def find_mins_maxs(obj):
    minx = maxx = miny = maxy = minz = maxz = None
    for p in obj.points:
        # p contains (x, y, z)
        if minx is None:
            minx = p[stl.Dimension.X]
            maxx = p[stl.Dimension.X]
            miny = p[stl.Dimension.Y]
            maxy = p[stl.Dimension.Y]
            minz = p[stl.Dimension.Z]
            maxz = p[stl.Dimension.Z]
        else:
            maxx = max(p[stl.Dimension.X], maxx)
            minx = min(p[stl.Dimension.X], minx)
            maxy = max(p[stl.Dimension.Y], maxy)
            miny = min(p[stl.Dimension.Y], miny)
            maxz = max(p[stl.Dimension.Z], maxz)
            minz = min(p[stl.Dimension.Z], minz)
    return minx, maxx, miny, maxy, minz, maxz


#
if len(sys.argv) < 2:
    sys.exit('Usage: %s <stl-file> [--spec-only]' % sys.argv[0])

if not os.path.exists(sys.argv[1]):
    sys.exit('ERROR: file %s was not found!' % sys.argv[1])

spec_only = False;
if len(sys.argv) > 2 and sys.argv[2] == "--spec-only":
  spec_only = True

main_body = mesh.Mesh.from_file(sys.argv[1])

minx, maxx, miny, maxy, minz, maxz = find_mins_maxs(main_body)

minx=round(minx,3)
maxx=round(maxx,3)
miny=round(miny,3)
maxy=round(maxy,3)
minz=round(minz,3)
maxz=round(maxz,3)

xsize = round(maxx-minx,3)
ysize = round(maxy-miny,3)
zsize = round(maxz-minz,3)

midx = round(xsize/2,3)
midy = round(ysize/2,3)
midz = round(zsize/2,3)

base_name = os.path.splitext(sys.argv[1])[0]
# the logic is easy from there

lst = ['obj =("',sys.argv[1],'");']
obj = ['\t\timport("',sys.argv[1],'");']

clean_name = base_name.replace ("-", "_")
spec_name  = "%s_spec" % clean_name
mod_name   = "draw_%s" % clean_name

full_path = os.getcwd() + os.path.sep

#lib_path = "C:/SCAD_Projects/Move-to-origin"
#obj_path = full_path.replace (os.path.sep, "/")

lib_path = "../../../libs/Move-STL-to-origin"
obj_path = "./"

if not spec_only:
  print ("// Automatically generated from file:", sys.argv[1])
  print ("//")
  print ("")
  print ("include <%s/stl_move_to_origin.scad>" % lib_path)
  print ("")
  print ("show_%s = false;" % clean_name)
  print ("")
  print ("/* [Hidden] */")
  print ("")

print ("%s = [" % spec_name)
print ("  \"%s\"," % sys.argv[1])
print ("  // dimensions (x,y,z)")
print ("  [%3.3f, %3.3f, %3.3f]," % (xsize, ysize, zsize))
print ("  // position (x,y,z)")
print ("  [%3.3f, %3.3f, %3.3f]," % (minx, miny, minz))
print ("  ];")

if not spec_only:
  print ("")
  print ("module %s (where=NE)" % mod_name)
  print ("{")
  print ("    move_stl_to_origin (%s, path=\"%s\", where=where);" % (spec_name, obj_path))
  print ("}")
  print ("")
  print ("if (show_%s)" % clean_name)
  print ("    %s();" % mod_name)
  print ("")


