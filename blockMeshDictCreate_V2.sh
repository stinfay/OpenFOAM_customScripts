#!/bin/bash

l=$1
w=$2
h=$3

c1=$4
c2=$5
c3=$6

xCells=$7
yCells=$8
zCells=$9

bcScale=8

echo $w
echo $c2

d=$(echo "scale=$bcScale; ($l+$h)*$c1" | bc)
r=$(echo "scale=$bcScale; $d/2" | bc)
d_c3=$(echo "scale=$bcScale; $d*$c3" | bc)
w_c2=$(echo "scale=$bcScale; $w*$c2/2" | bc)
arcR=$(echo "scale=$bcScale; $d*s(a(1))" | bc -l)
arcR_c=$(echo "scale=$bcScale; $d" | bc -l)
d2=$(echo "scale=$bcScale; $d*2" | bc)

echo $w_c2

fileName="system/blockMeshDict"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |" >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |" >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |" >> "$fileName"
echo "|  M anipulation  |                                                 |" >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "FoamFile"                         >> "$fileName"
echo "{"                                >> "$fileName"
echo "    version     2.0;"             >> "$fileName"
echo "    format      ascii;"           >> "$fileName"
echo "    class       dictionary;"      >> "$fileName"
echo "    object      blockMeshDict;"   >> "$fileName"
echo "}"                                >> "$fileName"

echo "" >> "$fileName"

echo "convertToMeters 1;" >> "$fileName"

echo "" >> "$fileName"

echo "vertices" >> "$fileName"
echo "("        >> "$fileName"
echo "    (0 $r -$w_c2)" >> "$fileName"
echo "    (-$r 0 -$w_c2)" >> "$fileName"
echo "    (0 -$r -$w_c2)" >> "$fileName"
echo "    ($r 0 -$w_c2)" >> "$fileName"
echo "    (0 $d -$w_c2)" >> "$fileName"
echo "    (-$d_c3 0 -$w_c2)" >> "$fileName"
echo "    (0 -$d -$w_c2)" >> "$fileName"
echo "    ($d 0 -$w_c2)" >> "$fileName"

echo "    (0 $r $w_c2)" >> "$fileName"
echo "    (-$r 0 $w_c2)" >> "$fileName"
echo "    (0 -$r $w_c2)" >> "$fileName"
echo "    ($r 0 $w_c2)" >> "$fileName"
echo "    (0 $d $w_c2)" >> "$fileName"
echo "    (-$d_c3 0 $w_c2)" >> "$fileName"
echo "    (0 -$d $w_c2)" >> "$fileName"
echo "    ($d 0 $w_c2)" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "blocks"   >> "$fileName"
echo "("        >> "$fileName"
echo "    hex (0 1 2 3  8 9 10 11) ($xCells $yCells $zCells) simpleGrading (1 1 1)" >> "$fileName"
echo "    hex (0 4 5 1  8 12 13 9) ($xCells $yCells $zCells) simpleGrading (1 1 1)" >> "$fileName"
echo "    hex (1 5 6 2  9 13 14 10) ($xCells $yCells $zCells) simpleGrading (1 1 1)" >> "$fileName"
echo "    hex (2 6 7 3  10 14 15 11) ($xCells $yCells $zCells) simpleGrading (1 1 1)" >> "$fileName"
echo "    hex (3 7 4 0  11 15 12 8) ($xCells $yCells $zCells) simpleGrading (1 1 1)" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "edges"    >> "$fileName"
echo "("        >> "$fileName"
echo "    arc 6 7 ($arcR -$arcR -$w_c2)" >> "$fileName"
echo "    arc 4 7 ($arcR $arcR -$w_c2)" >> "$fileName"
echo "    arc 14 15 ($arcR -$arcR $w_c2)" >> "$fileName"
echo "    arc 12 15 ($arcR $arcR $w_c2)" >> "$fileName"

echo "    polyLine 5 4 ((-$d2 $d -$w_c2))" >> "$fileName"
echo "    polyLine 5 6 ((-$d2 -$d -$w_c2))" >> "$fileName"
echo "    polyLine 13 12 ((-$d2 $d $w_c2))" >> "$fileName"
echo "    polyLine 13 14 ((-$d2 -$d $w_c2))" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "boundary" >> "$fileName"
echo "(" >> "$fileName"
echo "    inlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type patch;" >> "$fileName"
echo "        faces" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (6 14 15 7)" >> "$fileName"
echo "            (4 7 15 12)" >> "$fileName"
echo "        );" >> "$fileName"
echo "    }" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type patch;" >> "$fileName"
echo "        faces" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (5 4 12 13)" >> "$fileName"
echo "            (6 5 13 14)" >> "$fileName"
echo "        );" >> "$fileName"
echo "    }" >> "$fileName"
echo "    sideWalls" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type patch;" >> "$fileName"
echo "        faces" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (0 1 2 3)" >> "$fileName"
echo "            (0 4 5 1)" >> "$fileName"
echo "            (1 5 6 2)" >> "$fileName"
echo "            (2 6 7 3)" >> "$fileName"
echo "            (3 7 4 0)" >> "$fileName"
echo "            (8 9 10 11)" >> "$fileName"
echo "            (8 12 13 9)" >> "$fileName"
echo "            (9 13 14 10)" >> "$fileName"
echo "            (10 14 15 11)" >> "$fileName"
echo "            (11 15 12 8)" >> "$fileName"
echo "        );" >> "$fileName"
echo "    }" >> "$fileName"
echo ");" >> "$fileName"

