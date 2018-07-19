#!/bin/bash

stlName=$1
eMeshName="stlFile.eMesh"

# castellated mesh settings
maxLocalCells=100000
maxGlobalCells=2000000
minRefinementCells=10
maxLoadUnbalance=0.10
nCellsBetweenLevels=3
featureLevel=6
minRefine=5
maxRefine=6
resolveFeatureAngle=30

# snap settings
nSmoothPatch=3
tolerance=2.0
nSolveIter=30
nRelaxIter_snap=5
nFeatureSnapIter=10
implicitFeatureSnap=false
explicitFeatureSnap=true
multiRegionFeatureSnap=false

# add layer control settings
nSurfaceLayers=4
relativeSizes=true
expansionRatio=1.0
finalLayerThickness=0.3
minThickness=0.1
nGrow=0;
featureAngle=60
slipFeatureAngle=30
nRelaxIter_add=3
nSmoothSurfaceNormals=1
nSmoothNormals=3
nSmoothThickness=10
maxFaceThicknessRatio=0.5
maxThicknessToMedialRatio=0.3
minMedianAxisAngle=90
nBufferCellsNoExtrude=0
nLayerIter=50
minVol=0

# mesh quality settings
nSmoothScale=4
errorReduction=0.5

mergeTolerance=1e-6

bScale=8

fileName="system/snappyHexMeshDict"

bBoxTmp=$(surfaceCheck constant/triSurface/$stlName | grep -i "bounding box : " | grep -o -h --line-buffered "\-*[0-9.e\-]* \-*[0-9.e\-]* \-*[0-9.e\-]*")
bBox=($bBoxTmp)
for i in {0..5}; do
	bBoxFix[i]=$(echo "${bBox[$i]}" | sed -e "s/e/\*10\^/")
done

wScale=1
xWidth=$(echo "scale=$bScale; (${bBoxFix[3]}-(${bBoxFix[0]}))*$wScale" | bc)
yWidth=$(echo "scale=$bScale; (${bBoxFix[4]}-(${bBoxFix[1]}))*$wScale" | bc)
zWidth=$(echo "scale=$bScale; (${bBoxFix[5]}-(${bBoxFix[2]}))*$wScale" | bc)

xMin=$(echo "scale=$bScale; ${bBoxFix[0]}-($xWidth/2)*$wScale" | bc)
yMin=$(echo "scale=$bScale; ${bBoxFix[1]}-($yWidth/2)*$wScale" | bc)
zMin=$(echo "scale=$bScale; ${bBoxFix[2]}-($zWidth/2)*$wScale" | bc)

xMax=$(echo "scale=$bScale; ${bBoxFix[3]}+($xWidth/2)*$wScale" | bc)
yMax=$(echo "scale=$bScale; ${bBoxFix[4]}+($yWidth/2)*$wScale" | bc)
zMax=$(echo "scale=$bScale; ${bBoxFix[5]}+($zWidth/2)*$wScale" | bc)

inMeshX=$(echo "scale=$bScale; $xMax+($xWidth*1.1)" | bc)
inMeshY=$(echo "scale=$bScale; $yMax+($yWidth*1.1)" | bc)
inMeshZ=$(echo "scale=$bScale; $zMax+($zWidth*1.1)" | bc)

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "FoamFile"                         	>> "$fileName"
echo "{"                                	>> "$fileName"
echo "    version     2.0;"             	>> "$fileName"
echo "    format      ascii;"           	>> "$fileName"
echo "    class       dictionary;"      	>> "$fileName"
echo "    object      snappyHexMeshDict;"  	>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "castellatedMesh true;" 										>> "$fileName"
echo "snap true;" 													>> "$fileName"
echo "addLayers true;" 												>> "$fileName"
echo "geometry" 													>> "$fileName"
echo "{" 															>> "$fileName"
echo "    $stlName" 												>> "$fileName"
echo "    {" 														>> "$fileName"
echo "        type triSurfaceMesh;" 								>> "$fileName"
echo "        name stlModel;" 										>> "$fileName"
echo "    }" 														>> "$fileName"
echo "    refinementBox" 											>> "$fileName"
echo "    {" 														>> "$fileName"
echo "        type searchableBox;" 									>> "$fileName"
echo "        min ($xMin $yMin $zMin);" 							>> "$fileName"
echo "        max ($xMax $yMax $zMax);" 							>> "$fileName"
echo "    }" 														>> "$fileName"
echo "}" 															>> "$fileName"
echo "castellatedMeshControls" 										>> "$fileName"
echo "{" 															>> "$fileName"
echo "    maxLocalCells $maxLocalCells;" 							>> "$fileName"
echo "    maxGlobalCells $maxGlobalCells;" 							>> "$fileName"
echo "    minRefinementCells $minRefinementCells;" 					>> "$fileName"
echo "    maxLoadUnbalance $maxLoadUnbalance;" 						>> "$fileName"
echo "    nCellsBetweenLevels $nCellsBetweenLevels;" 				>> "$fileName"
echo "    features" 												>> "$fileName"
echo "    (" 														>> "$fileName"
echo "        {" 													>> "$fileName"
echo "            file \"$eMeshName\";" 							>> "$fileName"
echo "            level $featureLevel;" 							>> "$fileName"
echo "        }" 													>> "$fileName"
echo "    );" 														>> "$fileName"
echo "    refinementSurfaces" 										>> "$fileName"
echo "    {" 														>> "$fileName"
echo "        stlModel" 											>> "$fileName"
echo "        {" 													>> "$fileName"
echo "            level ($minRefine $maxRefine);" 					>> "$fileName"
echo "            patchInfo" 										>> "$fileName"
echo "            {" 												>> "$fileName"
echo "                type wall;" 									>> "$fileName"
echo "                inGroups (stlModelGroup);" 					>> "$fileName"
echo "            }" 												>> "$fileName"
echo "        }" 													>> "$fileName"
echo "    }" 														>> "$fileName"
echo "    resolveFeatureAngle $resolveFeatureAngle;" 				>> "$fileName"
echo "    refinementRegions" 										>> "$fileName"
echo "    {" 														>> "$fileName"
echo "        refinementBox" 										>> "$fileName"
echo "        {" 													>> "$fileName"
echo "            mode inside;" 									>> "$fileName"
echo "            levels ((1e15 4));" 								>> "$fileName"
echo "        }" 													>> "$fileName"
echo "    }" 														>> "$fileName"
echo "    locationInMesh ($inMeshX $inMeshY $inMeshZ);" 			>> "$fileName"
echo "    allowFreeStandingZoneFaces true;" 						>> "$fileName"
echo "}" 															>> "$fileName"
echo "snapControls" 												>> "$fileName"
echo "{" 															>> "$fileName"
echo "    nSmoothPatch $nSmoothPatch;" 								>> "$fileName"
echo "    tolerance $tolerance;" 									>> "$fileName"
echo "    nSolveIter $nSolveIter;" 									>> "$fileName"
echo "    nRelaxIter $nRelaxIter_snap;" 							>> "$fileName"
echo "    nFeatureSnapIter $nFeatureSnapIter;" 						>> "$fileName"
echo "    implicitFeatureSnap $implicitFeatureSnap;" 				>> "$fileName"
echo "    explicitFeatureSnap $explicitFeatureSnap;" 				>> "$fileName"
echo "    multiRegionFeatureSnap $multiRegionFeatureSnap;" 			>> "$fileName"
echo "}" 															>> "$fileName"
echo "addLayersControls" 											>> "$fileName"
echo "{" 															>> "$fileName"
echo "    relativeSizes true;" 										>> "$fileName"
echo "    layers" 													>> "$fileName"
echo "    {" 														>> "$fileName"
echo "        \"(stlModel).*\"" 									>> "$fileName"
echo "        {" 													>> "$fileName"
echo "            nSurfaceLayers $nSurfaceLayers;" 					>> "$fileName"
echo "        }" 													>> "$fileName"
echo "    }" 														>> "$fileName"
echo "    expansionRatio $expansionRatio;" 							>> "$fileName"
echo "    finalLayerThickness $finalLayerThickness;" 				>> "$fileName"
echo "    minThickness $minThickness;" 								>> "$fileName"
echo "    nGrow $nGrow;" 											>> "$fileName"
echo "    featureAngle $featureAngle;" 								>> "$fileName"
echo "    slipFeatureAngle $slipFeatureAngle;" 						>> "$fileName"
echo "    nRelaxIter $nRelaxIter_add;" 								>> "$fileName"
echo "    nSmoothSurfaceNormals $nSmoothSurfaceNormals;" 			>> "$fileName"
echo "    nSmoothNormals $nSmoothNormals;" 							>> "$fileName"
echo "    nSmoothThickness $nSmoothThickness;" 						>> "$fileName"
echo "    maxFaceThicknessRatio $maxFaceThicknessRatio;" 			>> "$fileName"
echo "    maxThicknessToMedialRatio $maxThicknessToMedialRatio;" 	>> "$fileName"
echo "    minMedianAxisAngle $minMedianAxisAngle;" 					>> "$fileName"
echo "    nBufferCellsNoExtrude $nBufferCellsNoExtrude;" 			>> "$fileName"
echo "    nLayerIter $nLayerIter;" 									>> "$fileName"
echo "    minVol $minVol;" 											>> "$fileName"
echo "}" 															>> "$fileName"
echo "meshQualityControls" 											>> "$fileName"
echo "{" 															>> "$fileName"
echo "    #include \"meshQualityDict\"" 							>> "$fileName"
echo "    nSmoothScale $nSmoothScale;" 								>> "$fileName"
echo "    errorReduction $errorReduction;" 							>> "$fileName"
echo "}" 															>> "$fileName"
echo "writeFlags" 													>> "$fileName"
echo "(" 															>> "$fileName"
echo "    scalarLevels" 											>> "$fileName"
echo "    layerSets" 												>> "$fileName"
echo "    layerFields" 												>> "$fileName"
echo ");" 															>> "$fileName"
echo "mergeTolerance $mergeTolerance;" 								>> "$fileName"