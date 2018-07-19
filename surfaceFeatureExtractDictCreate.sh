#!/bin/bash

stlName=$1
includedAngle=$2
eMeshName="stlFile.emesh"
fileName="system/surfaceFeatureExtractDict"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "FoamFile"                         				>> "$fileName"
echo "{"                                				>> "$fileName"
echo "    version     2.0;"             				>> "$fileName"
echo "    format      ascii;"           				>> "$fileName"
echo "    class       dictionary;"      				>> "$fileName"
echo "    object      surfaceFeatureExtractDict;"   	>> "$fileName"
echo "}"                                				>> "$fileName"

echo "" >> "$fileName"

echo "$stlName" 								>> "$fileName"
echo "{" 										>> "$fileName"
echo "    extractionMethod extractFromSurface;" >> "$fileName"
echo "    extractFromSurfaceCoeffs" 			>> "$fileName"
echo "    {" 									>> "$fileName"
echo "        includedAngle $includedAngle;" 	>> "$fileName"
echo "    }" 									>> "$fileName"
echo "    subsetFeatures" 						>> "$fileName"
echo "    {" 									>> "$fileName"
echo "        nonMinifoldEdges no;" 			>> "$fileName"
echo "        openEdges yes;" 					>> "$fileName"
echo "    }" 									>> "$fileName"
echo "    writeObj yes;" 						>> "$fileName"
echo "}" 										>> "$fileName"
