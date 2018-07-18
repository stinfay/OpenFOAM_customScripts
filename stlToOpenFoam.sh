#!/bin/bash

# user input
stlFile=$1
caseDir=$2
stlName=$(basename $stlFile)
direction=$3
up=$4
vel=$5
AOA=$6

endTime=$7
deltaT=$8

meshBox=$9

# make case directory filesystem
mkdir $caseDir
mkdir $caseDir/constant
mkdir $caseDir/system
mkdir $caseDir/constant/triSurface

# copy stl to triSurface
cp $stlFile $caseDir/constant/triSurface

# enter case directory
cd $caseDir



# get bounding box sizes for stl
bcScale=8
bBoxTmp=$(surfaceCheck constant/triSurface/$stlFile | grep -i "bounding box : " | grep -o -h --line-buffered "\-*[0-9.e\-]* \-*[0-9.e\-]* \-*[0-9.e\-]*")
bBox=($bBoxTmp)
for i in {0..5}; do
	bBoxFix[i]=$(echo "${bBox[$i]}" | sed -e "s/e/\*10\^/")
done

bBoxX=$(echo "scale=$bcScale; (${bBoxFix[0]}+${bBoxFix[3]})/2" | bc)
bBoxY=$(echo "scale=$bcScale; (${bBoxFix[1]}+${bBoxFix[4]})/2" | bc)
bBoxZ=$(echo "scale=$bcScale; (${bBoxFix[2]}+${bBoxFix[5]})/2" | bc)

wScale=1
xWidth=$(echo "scale=$bcScale; (${bBoxFix[3]}-(${bBoxFix[0]}))*$wScale" | bc)
yWidth=$(echo "scale=$bcScale; (${bBoxFix[4]}-(${bBoxFix[1]}))*$wScale"   | bc)
zWidth=$(echo "scale=$bcScale; (${bBoxFix[5]}-(${bBoxFix[2]}))*$wScale"   | bc)

AOA=$(echo "scale=$bcScale; $AOA*(4*a(1)/180)" | bc -l)

velX=0
velY=0
velZ=0
if [ $direction = "1" ]; then
	xWidth=$(echo "scale=$bcScale; $xWidth*2" | bc)
	velX=$(echo "scale=$bcScale; -$vel*c($AOA)" | bc -l)
elif [ $direction = "2" ]; then
	yWidth=$(echo "scale=$bcScale; $yWidth*2" | bc)
	velY=$(echo "scale=$bcScale; -$vel*c($AOA)" | bc -l)
elif [ $direction = "3" ]; then
	zWidth=$(echo "scale=$bcScale; $zWidth*2" | bc)
	velZ=$(echo "scale=$bcScale; -$vel*c($AOA)" | bc -l)
elif [ $direction = "-1" ]; then
	xWidth=$(echo "scale=$bcScale; $xWidth*2" | bc)
	velX=$(echo "scale=$bcScale; $vel*c($AOA)" | bc -l)
elif [ $direction = "-2" ]; then
	yWidth=$(echo "scale=$bcScale; $yWidth*2" | bc)
	velY=$(echo "scale=$bcScale; $vel*c($AOA)" | bc -l)
elif [ $direction = "-3" ]; then
	zWidth=$(echo "scale=$bcScale; $zWidth*2" | bc)
	velZ=$(echo "scale=$bcScale; $vel*c($AOA)" | bc -l)
fi

if [ $up = "1" ]; then
	velX=$(echo "scale=$bcScale; $vel*s($AOA)" | bc -l)
elif [ $up = "-1" ]; then
	velX=$(echo "scale=$bcScale; -$vel*s($AOA)" | bc -l)
elif [ $up = "2" ]; then
	velY=$(echo "scale=$bcScale; $vel*s($AOA)" | bc -l)
elif [ $up = "-2" ]; then
	velY=$(echo "scale=$bcScale; -$vel*s($AOA)" | bc -l)
elif [ $up = "3" ]; then
	velZ=$(echo "scale=$bcScale; $vel*s($AOA)" | bc -l)
elif [ $up = "-3" ]; then
	velZ=$(echo "scale=$bcScale; -$vel*s($AOA)" | bc -l)
fi

hScale=5
if [ $(echo "$direction" | sed -e "s/-//") = "1" ]; then
	meshBoxX=$meshBox
	l=$xWidth
	if [ $(echo $up | sed -e "s/-//") = "2" ]; then
		h=$yWidth
		w=$zWidth
		meshBoxY=$(echo "scale=1; $meshBox*($yWidth/$xWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
		meshBoxZ=$(echo "scale=1; $meshBox*($zWidth/$xWidth)*1" | bc | sed -e "s/\.[0-9*]//")
	elif [ $(echo $up | sed -e "s/-//") = "3" ]; then
		h=$zWidth
		w=$yWidth
		meshBoxY=$(echo "scale=1; $meshBox*($yWidth/$xWidth)*1" | bc | sed -e "s/\.[0-9*]//")
		meshBoxZ=$(echo "scale=1; $meshBox*($zWidth/$xWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
	fi
elif [ $(echo "$direction" | sed -e "s/-//") = "2" ]; then
	meshBoxY=$meshBox
	l=$yWidth
	if [ $(echo $up | sed -e "s/-//") = "1" ]; then
		h=$xWidth
		w=$zWidth
		meshBoxX=$(echo "scale=1; $meshBox*($xWidth/$yWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
		meshBoxZ=$(echo "scale=1; $meshBox*($zWidth/$yWidth)*1" | bc | sed -e "s/\.[0-9*]//")
	elif [ $(echo $up | sed -e "s/-//") = "3" ]; then
		h=$zWidth
		w=$xWidth
		meshBoxX=$(echo "scale=1; $meshBox*($xWidth/$yWidth)*1" | bc | sed -e "s/\.[0-9*]//")
		meshBoxZ=$(echo "scale=1; $meshBox*($zWidth/$yWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
	fi
elif [ $(echo "$direction" | sed -e "s/-//") = "3" ]; then
	meshBoxZ=$meshBox
	l=$zWidth
	if [ $(echo $up | sed -e "s/-//") = "1" ]; then
		h=$xWidth
		w=$yWidth
		meshBoxX=$(echo "scale=1; $meshBox*($xWidth/$zWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
		meshBoxY=$(echo "scale=1; $meshBox*($yWidth/$zWidth)*1" | bc | sed -e "s/\.[0-9*]//")
	elif [ $(echo $up | sed -e "s/-//") = "2" ]; then
		h=$yWidth
		w=$xWidth
		meshBoxX=$(echo "scale=1; $meshBox*($xWidth/$zWidth)*1" | bc | sed -e "s/\.[0-9*]//")
		meshBoxY=$(echo "scale=1; $meshBox*($yWidth/$zWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
	fi
fi

# create controlDict
controlDictCreate.sh $endTime $deltaT 1

# create dictionary files for mesh generation
surfaceFeatureExtractDictCreate.sh $stlName 180
blockMeshDictCreate.sh $l $w $h 2.5 3 $meshBoxX $meshBoxY $meshBoxZ $bBoxX $bBoxY $bBoxZ $direction $up
snappyHexMeshDictCreate.sh $stlName
meshQualityDictCreate.sh
fvSchemesCreate.sh
fvSolutionCreate.sh

# create initial conditions
initCreate.sh $velX $velY $velZ

# create transport and turbulence properties
constantPropertiesCreate.sh

# generate mesh
touch log.txt
#surfaceFeatureExtract 2>log.txt
#blockMesh 2>log.txt
#paraFoam
#checkMesh >> log.txt 2>&1
#snappyHexMesh -overwrite 2>log.txt
#checkMesh >> log.txt 2>&1

#simpleFoam
