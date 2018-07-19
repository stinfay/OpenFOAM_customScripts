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
mv -f $caseDir/constant/triSurface/$stlFile $caseDir/constant/triSurface/stlFile.stl

# enter case directory
cd $caseDir

# rotate stl to match axes convention
bcScale=8
I=(0 0 0)
i1=$(echo "$direction" | sed -e "s/-//")
i2=$(echo "$up" | sed -e "s/-//")
ind1=$(($i1-1))
ind2=$(($i2-1))

I[$ind1]=$(echo "scale=$bcScale; $direction/$i1" | bc)
I[$ind2]=$(echo "scale=$bcScale; $up/$i2" | bc)

surfaceTransformPoints -rotate "((${I[0]} ${I[1]} ${I[2]}) (1 1 0))" constant/triSurface/stlFile.stl constant/triSurface/stlFile.stl

# get bounding box sizes for stl
bBoxTmp=$(surfaceCheck constant/triSurface/stlFile.stl | grep -i "bounding box : " | grep -o -h --line-buffered "\-*[0-9.e\-]* \-*[0-9.e\-]* \-*[0-9.e\-]*")
bBox=($bBoxTmp)
for i in {0..5}; do
	bBoxFix[i]=$(echo "${bBox[$i]}" | sed -e "s/e/\*10\^/")
done

bBoxX=$(echo "scale=$bcScale; -(${bBoxFix[0]}+${bBoxFix[3]})/2" | bc)
bBoxY=$(echo "scale=$bcScale; -(${bBoxFix[1]}+${bBoxFix[4]})/2" | bc)
bBoxZ=$(echo "scale=$bcScale; -(${bBoxFix[2]}+${bBoxFix[5]})/2" | bc)

surfaceTransformPoints -translate "($bBoxX $bBoxY $bBoxZ)" constant/triSurface/stlFile.stl constant/triSurface/stlFile.stl

wScale=1
xWidth=$(echo "scale=$bcScale; (${bBoxFix[3]}-(${bBoxFix[0]}))*$wScale" | bc)
yWidth=$(echo "scale=$bcScale; (${bBoxFix[4]}-(${bBoxFix[1]}))*$wScale"   | bc)
zWidth=$(echo "scale=$bcScale; (${bBoxFix[5]}-(${bBoxFix[2]}))*$wScale"   | bc)

AOA=$(echo "scale=$bcScale; $AOA*(4*a(1)/180)" | bc -l)

xWidth=$(echo "scale=$bcScale; $xWidth*2" | bc)
velX=$(echo "scale=$bcScale; -$vel*c($AOA)" | bc -l)
velY=$(echo "scale=$bcScale; $vel*s($AOA)" | bc -l)
velZ=0


hScale=5
meshBoxX=$meshBox
l=$xWidth
h=$yWidth
w=$zWidth
meshBoxY=$(echo "scale=1; $meshBox*($yWidth/$xWidth)*$hScale" | bc | sed -e "s/\.[0-9*]//")
meshBoxZ=$(echo "scale=1; $meshBox*($zWidth/$xWidth)*1" | bc | sed -e "s/\.[0-9*]//")

# create controlDict
controlDictCreate.sh $endTime $deltaT 1

# create dictionary files for mesh generation
surfaceFeatureExtractDictCreate.sh stlFile.stl 180

#blockMeshDictCreate.sh $l $w $h 2.5 3 $meshBoxX $meshBoxY $meshBoxZ 0 0 0 1 2
blockMeshDictCreate_V2.sh $l $w $h 3 5 2 $meshBoxX $meshBoxX $meshBoxZ

snappyHexMeshDictCreate.sh stlFile.stl
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
