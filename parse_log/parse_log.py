


import os
import sys
from str_utils import before, after




path = sys.argv[1]

with open(path) as f:
  lines = f.read().split('\n')

bom_lines = []
bom = {}

list_all = False

for line in lines:
  if line.startswith ("ECHO:"):
    data = after (line, "ECHO: ")

    data = data.strip('"')

    if data.startswith("bom"):
      data = after (data, "bom,")
      data = data.strip()
      #print (data)

      if data.startswith ("assembly"):
        assembly_name = after (data, ",").strip()
      elif data.startswith ("/assembly"):
        assembly_name = "none"
      else:
        bom_lines.append (assembly_name + "," + data)

        if data in bom:
          bom [data] += 1
        else:
          bom [data] = 1

if list_all:
  for s in bom_lines:
    print (s)
  print (len(bom_lines))

  print ("---------------------")

# output grouped list
count = 0
print ("Quantity,Class,Type,Spec,Spec2,Spec3,Spec4")
for key in bom:
  print ("%s,%s" % ( bom[key], key))
  count += bom[key]

# total num items for check
print (count)
