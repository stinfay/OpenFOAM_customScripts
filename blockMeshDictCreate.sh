#!/bin/bash

l=$1
w=$2
h=$3

c1=$4
c2=$5

xCells=$6
yCells=$7
zCells=$8

Ox=$9
Oy=${10}
Oz=${11}

direction=${12}
up=${13}

xP="(2 6 5 1)"
yP="(3 7 6 2)"
zP="(4 5 6 7)"
xM="(0 4 7 3)"
yM="(1 5 4 0)"
zM="(0 3 2 1)"

bcScale=8

r=$(echo "scale=$bcScale; ($l+$h*2)*$c1" | bc)

xCell=(0.5 0.5 0.5 0.5)
yCell=(0.5 0.5 0.5 0.5)
zCell=(0.5 0.5 0.5 0.5)

arc1=(0 0 0 0 0)
arc2=(0 0 0 0 0)

eRatioX=8
eRatioY=8
eRatioZ=8

eRatioXInv=$(echo "scale=$bcScale; 1/$eRatioX" | bc)
eRatioYInv=$(echo "scale=$bcScale; 1/$eRatioY" | bc)
eRatioZInv=$(echo "scale=$bcScale; 1/$eRatioZ" | bc)

if [ $direction = "1" ]; then
	inlet=$xP
	outlet=$xM
	xMax=$(echo "scale=$bcScale; $Ox-$r/2" | bc)
	xMin=$(echo "scale=$bcScale; $xMax-($l+$h*2)*$c2" | bc)
	yMax=$(echo "scale=$bcScale; $Oy+$r" | bc)
	yMin=$(echo "scale=$bcScale; $Oy-$r" | bc)
	zMax=$(echo "scale=$bcScale; $Oz+$r" | bc)
	zMin=$(echo "scale=$bcScale; $Oz-$r" | bc)
	eRatioX=1
	xCell[0]=$c2
	xCell[1]=$(echo "scale=$bcScale; $c1/2" | bc)
	xCell[3]=0.4
	xCell[2]=0.6
	if [ $up = "2" ]; then
		upperWall=$yP
		lowerWall=$yM
		front=$zP
		back=$zM
		arc1=(5 6 $(echo "scale=$bcScale; $xMax+$r" | bc) $Oy $zMax)
		arc2=(1 2 $(echo "scale=$bcScale; $xMax+$r" | bc) $Oy $zMin)
	elif [ $up = "-2" ]; then
		upperWall=$yM
		lowerWall=$yP
		front=$zM
		back=$zP
		arc1=(5 6 $(echo "scale=$bcScale; $xMax+$r" | bc) $Oy $zMax)
		arc2=(1 2 $(echo "scale=$bcScale; $xMax+$r" | bc) $Oy $zMin)
	elif [ $up = "3" ]; then
		upperWall=$zP
		lowerWall=$zM
		front=$yP
		back=$yM
		arc1=(5 1 $(echo "scale=$bcScale; $xMax+$r" | bc) $yMin $Oz)
		arc2=(6 2 $(echo "scale=$bcScale; $xMax+$r" | bc) $yMax $Oz)
	elif [ $up = "-3" ]; then
		upperWall=$zM
		lowerWall=$zP
		front=$yM
		back=$yP
		arc1=(5 1 $(echo "scale=$bcScale; $xMax+$r" | bc) $yMin $Oz)
		arc2=(6 2 $(echo "scale=$bcScale; $xMax+$r" | bc) $yMax $Oz)
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
elif [ $direction = "2" ]; then
	inlet=$yP
	outlet=$yM
	yMax=$(echo "scale=$bcScale; $Oy-$r/2" | bc)
	yMin=$(echo "scale=$bcScale; $yMax-($l+$h*2)*$c2" | bc)
	xMax=$(echo "scale=$bcScale; $Ox+$r" | bc)
	xMin=$(echo "scale=$bcScale; $Ox-$r" | bc)
	zMax=$(echo "scale=$bcScale; $Oz+$r" | bc)
	zMin=$(echo "scale=$bcScale; $Oz-$r" | bc)
	eRatioY=1
	yCell[0]=$c2
	yCell[1]=$(echo "scale=$bcScale; $c1/2" | bc)
	yCell[3]=0.4
	yCell[2]=0.6
	if [ $up = "1" ]; then
		upperWall=$xP
		lowerWall=$xM
		front=$zM
		back=$zP
		arc1=(6 7 $Ox $(echo "scale=$bcScale; $yMax+$r" | bc) $zMax)
		arc2=(2 3 $Ox $(echo "scale=$bcScale; $yMax+$r" | bc) $zMin)
	elif [ $up = "-1" ]; then
		upperWall=$xM
		lowerWall=$xP
		front=$zP
		back=$zM
		arc1=(6 7 $Ox $(echo "scale=$bcScale; $yMax+$r" | bc) $zMax)
		arc2=(2 3 $Ox $(echo "scale=$bcScale; $yMax+$r" | bc) $zMin)
	elif [ $up = "3" ]; then
		upperWall=$zP
		lowerWall=$zM
		front=$xP
		back=$xM
		arc1=(7 3 $xMin $(echo "scale=$bcScale; $yMax+$r" | bc) $Oz)
		arc2=(6 2 $xMax $(echo "scale=$bcScale; $yMax+$r" | bc) $Oz)
	elif [ $up = "-3" ]; then
		upperWall=$zM
		lowerWall=$zP
		front=$xM
		back=$xP
		arc1=(7 3 $xMin $(echo "scale=$bcScale; $yMax+$r" | bc) $Oz)
		arc2=(6 2 $xMax $(echo "scale=$bcScale; $yMax+$r" | bc) $Oz)
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
elif [ $direction = "3" ]; then
	inlet=$zP
	outlet=$zM
	zMax=$(echo "scale=$bcScale; $Oz-$r/2" | bc)
	zMin=$(echo "scale=$bcScale; $zMax-($l+$h*2)*$c2" | bc)
	yMax=$(echo "scale=$bcScale; $Oy+$r" | bc)
	yMin=$(echo "scale=$bcScale; $Oy-$r" | bc)
	xMax=$(echo "scale=$bcScale; $Ox+$r" | bc)
	xMin=$(echo "scale=$bcScale; $Ox-$r" | bc)
	eRatioZ=1
	zCell[0]=$c2
	zCell[1]=$(echo "scale=$bcScale; $c1/2" | bc)
	zCell[3]=0.4
	zCell[2]=0.6
	if [ $up = "1" ]; then
		upperWall=$xP
		lowerWall=$xM
		front=$yM
		back=$yP
		arc1=(5 4 $Ox $yMin $(echo "scale=$bcScale; $zMax+$r" | bc))
		arc2=(6 7 $Ox $yMax $(echo "scale=$bcScale; $zMax+$r" | bc))
	elif [ $up = "-1" ]; then
		upperWall=$xM
		lowerWall=$xP
		front=$yP
		back=$yM
		arc1=(5 4 $Ox $yMin $(echo "scale=$bcScale; $zMax+$r" | bc))
		arc2=(6 7 $Ox $yMax $(echo "scale=$bcScale; $zMax+$r" | bc))
	elif [ $up = "2" ]; then
		upperWall=$yP
		lowerWall=$yM
		front=$xP
		back=$xM
		arc1=(5 6 $xMax $Oy $(echo "scale=$bcScale; $zMax+$r" | bc))
		arc2=(4 7 $xMin $Oy $(echo "scale=$bcScale; $zMax+$r" | bc))
	elif [ $up = "-2" ]; then
		upperWall=$yM
		lowerWall=$yP
		front=$xM
		back=$xP
		arc1=(5 6 $xMax $Oy $(echo "scale=$bcScale; $zMax+$r" | bc))
		arc2=(4 7 $xMin $Oy $(echo "scale=$bcScale; $zMax+$r" | bc))
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
elif [ $direction = "-1" ]; then
	inlet=$xM
	outlet=$xP
	xMin=$(echo "scale=$bcScale; $Ox+$r/2" | bc)
	xMax=$(echo "scale=$bcScale; $xMin+($l+$h*2)*$c2" | bc)
	yMax=$(echo "scale=$bcScale; $Oy+$r" | bc)
	yMin=$(echo "scale=$bcScale; $Oy-$r" | bc)
	zMax=$(echo "scale=$bcScale; $Oz+$r" | bc)
	zMin=$(echo "scale=$bcScale; $Oz-$r" | bc)
	eRatioXInv=1
	xCell[1]=$c2
	xCell[0]=$(echo "scale=$bcScale; $c1/2" | bc)
	xCell[2]=0.4
	xCell[3]=0.6
	if [ $up = "2" ]; then
		upperWall=$yP
		lowerWall=$yM
		front=$zM
		back=$zP
		arc1=(4 7 $(echo "scale=$bcScale; $xMin-$r" | bc) $Oy $zMax)
		arc2=(0 3 $(echo "scale=$bcScale; $xMin-$r" | bc) $Oy $zMin)
	elif [ $up = "-2" ]; then
		upperWall=$yM
		lowerWall=$yP
		front=$zP
		back=$zM
		arc1=(4 7 $(echo "scale=$bcScale; $xMin-$r" | bc) $Oy $zMax)
		arc2=(0 3 $(echo "scale=$bcScale; $xMin-$r" | bc) $Oy $zMin)
	elif [ $up = "3" ]; then
		upperWall=$zP
		lowerWall=$zM
		front=$yP
		back=$yM
		arc1=(4 0 $(echo "scale=$bcScale; $xMin-$r" | bc) $yMin $Oz)
		arc2=(7 3 $(echo "scale=$bcScale; $xMin-$r" | bc) $yMax $Oz)
	elif [ $up = "-3" ]; then
		upperWall=$zM
		lowerWall=$zP
		front=$yM
		back=$yP
		arc1=(4 0 $(echo "scale=$bcScale; $xMin-$r" | bc) $yMin $Oz)
		arc2=(7 3 $(echo "scale=$bcScale; $xMin-$r" | bc) $yMax $Oz)
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
elif [ $direction = "-2" ]; then
	inlet=$yM
	outlet=$yP
	yMin=$(echo "scale=$bcScale; $Oy+$r/2" | bc)
	yMax=$(echo "scale=$bcScale; $yMin+($l+$h*2)*$c2" | bc)
	xMax=$(echo "scale=$bcScale; $Ox+$r" | bc)
	xMin=$(echo "scale=$bcScale; $Ox-$r" | bc)
	zMax=$(echo "scale=$bcScale; $Oz+$r" | bc)
	zMin=$(echo "scale=$bcScale; $Oz-$r" | bc)
	eRatioYInv=1
	yCell[1]=$c2
	yCell[0]=$(echo "scale=$bcScale; $c1/2" | bc)
	yCell[2]=0.4
	yCell[3]=0.6
	if [ $up = "1" ]; then
		upperWall=$xP
		lowerWall=$xM
		front=$zM
		back=$zP
		arc1=(5 4 $Ox $(echo "scale=$bcScale; $yMin-$r" | bc) $zMax)
		arc2=(1 0 $Ox $(echo "scale=$bcScale; $yMin-$r" | bc) $zMin)
	elif [ $up = "-1" ]; then
		upperWall=$xM
		lowerWall=$xP
		front=$zP
		back=$zM
		arc1=(5 4 $Ox $(echo "scale=$bcScale; $yMin-$r" | bc) $zMax)
		arc2=(1 0 $Ox $(echo "scale=$bcScale; $yMin-$r" | bc) $zMin)
	elif [ $up = "3" ]; then
		upperWall=$zP
		lowerWall=$zM
		front=$xP
		back=$xM
		arc1=(5 1 $xMax $(echo "scale=$bcScale; $yMin-$r" | bc) $Oz)
		arc2=(4 0 $xMin $(echo "scale=$bcScale; $yMin-$r" | bc) $Oz)
	elif [ $up = "-3" ]; then
		upperWall=$zM
		lowerWall=$zP
		front=$xM
		back=$xP
		arc1=(5 1 $xMax $(echo "scale=$bcScale; $yMin-$r" | bc) $Oz)
		arc2=(4 0 $xMin $(echo "scale=$bcScale; $yMin-$r" | bc) $Oz)
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
elif [ $direction = "-3" ]; then
	inlet=$zM
	outlet=$zP
	zMin=$(echo "scale=$bcScale; $Oz+$r/2" | bc)
	zMax=$(echo "scale=$bcScale; $zMin+($l+$h*2)*$c2" | bc)
	yMax=$(echo "scale=$bcScale; $Oy+$r" | bc)
	yMin=$(echo "scale=$bcScale; $Oy-$r" | bc)
	xMax=$(echo "scale=$bcScale; $Ox+$r" | bc)
	xMin=$(echo "scale=$bcScale; $Ox-$r" | bc)
	zCell[1]=$c2
	zCell[0]=$(echo "scale=$bcScale; $c1/2" | bc)
	zCell[2]=0.4
	zCell[3]=0.6
	if [ $up = "1" ]; then
		upperWall=$xP
		lowerWall=$xM
		front=$yM
		back=$yP
		arc1=(1 0 $Ox $yMin $(echo "scale=$bcScale; $zMin-$r" | bc))
		arc2=(2 3 $Ox $yMax $(echo "scale=$bcScale; $zMin-$r" | bc))
	elif [ $up = "-1" ]; then
		upperWall=$xM
		lowerWall=$xP
		front=$yP
		back=$yM
		arc1=(1 0 $Ox $yMin $(echo "scale=$bcScale; $zMin-$r" | bc))
		arc2=(2 3 $Ox $yMax $(echo "scale=$bcScale; $zMin-$r" | bc))
	elif [ $up = "2" ]; then
		upperWall=$yP
		lowerWall=$yM
		front=$xP
		back=$xM
		arc1=(1 2 $xMax $Oy $(echo "scale=$bcScale; $zMin-$r" | bc))
		arc2=(0 3 $xMin $Oy $(echo "scale=$bcScale; $zMin-$r" | bc))
	elif [ $up = "-2" ]; then
		upperWall=$yM
		lowerWall=$yP
		front=$xM
		back=$xP
		arc1=(1 2 $xMax $Oy $(echo "scale=$bcScale; $zMin-$r" | bc))
		arc2=(0 3 $xMin $Oy $(echo "scale=$bcScale; $zMin-$r" | bc))
	else
		echo "error: directions choosen for flight direction and up are inconsistant"
	fi
fi

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
echo "    ($xMin $yMin $zMin)" >> "$fileName"
echo "    ($xMax $yMin $zMin)" >> "$fileName"
echo "    ($xMax $yMax $zMin)" >> "$fileName"
echo "    ($xMin $yMax $zMin)" >> "$fileName"
echo "    ($xMin $yMin $zMax)" >> "$fileName"
echo "    ($xMax $yMin $zMax)" >> "$fileName"
echo "    ($xMax $yMax $zMax)" >> "$fileName"
echo "    ($xMin $yMax $zMax)" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "blocks"   >> "$fileName"
echo "("        >> "$fileName"
echo "    hex (0 1 2 3 4 5 6 7) ($xCells $yCells $zCells)" >> "$fileName"
echo "    simpleGrading" >> "$fileName"
echo "    (" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (${xCell[0]} ${xCell[2]} $eRatioXInv)" >> "$fileName"
echo "            (${xCell[1]} ${xCell[3]} $eRatioX)" >> "$fileName"
echo "        )" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (${yCell[0]} ${yCell[2]} $eRatioYInv)" >> "$fileName"
echo "            (${yCell[1]} ${yCell[3]} $eRatioY)" >> "$fileName"
echo "        )" >> "$fileName"
echo "        (" >> "$fileName"
echo "            (${zCell[0]} ${zCell[2]} $eRatioZInv)" >> "$fileName"
echo "            (${zCell[1]} ${zCell[3]} $eRatioZ)" >> "$fileName"
echo "        )" >> "$fileName"
echo "    )" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "edges"    >> "$fileName"
echo "("        >> "$fileName"
echo "    arc ${arc1[0]} ${arc1[1]} (${arc1[2]} ${arc1[3]} ${arc1[4]})" >> "$fileName"
echo "    arc ${arc2[0]} ${arc2[1]} (${arc2[2]} ${arc2[3]} ${arc2[4]})" >> "$fileName"
echo ");"       >> "$fileName"

echo "" >> "$fileName"

echo "boundary"                 >> "$fileName"
echo "("                        >> "$fileName"
echo "    frontAndBack"         >> "$fileName"
echo "    {"                    >> "$fileName"
echo "        type patch;"      >> "$fileName"
echo "        faces"            >> "$fileName"
echo "        ("                >> "$fileName"
echo "            $front"   	>> "$fileName"
echo "            $back"    	>> "$fileName"
echo "        );"               >> "$fileName"
echo "    }"                    >> "$fileName"
echo "    inlet"                >> "$fileName"
echo "    {"                    >> "$fileName"
echo "        type patch;"      >> "$fileName"
echo "        faces"            >> "$fileName"
echo "        ("                >> "$fileName"
echo "            $inlet"    	>> "$fileName"
echo "        );"               >> "$fileName"
echo "    }"                    >> "$fileName"
echo "    outlet"               >> "$fileName"
echo "    {"                    >> "$fileName"
echo "        type patch;"      >> "$fileName"
echo "        faces"            >> "$fileName"
echo "        ("                >> "$fileName"
echo "            $outlet"    	>> "$fileName"
echo "        );"               >> "$fileName"
echo "    }"                    >> "$fileName"
echo "    lowerWall"            >> "$fileName"
echo "    {"                    >> "$fileName"
echo "        type wall;"       >> "$fileName"
echo "        faces"            >> "$fileName"
echo "        ("                >> "$fileName"
echo "            $lowerWall"   >> "$fileName"
echo "        );"               >> "$fileName"
echo "    }"                    >> "$fileName"
echo "    upperWall"            >> "$fileName"
echo "    {"                    >> "$fileName"
echo "        type wall;"       >> "$fileName"
echo "        faces"            >> "$fileName"
echo "        ("                >> "$fileName"
echo "            $upperWall"   >> "$fileName"
echo "        );"               >> "$fileName"
echo "    }"                    >> "$fileName"
echo ");"                       >> "$fileName"
