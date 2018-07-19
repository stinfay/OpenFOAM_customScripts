#!/bin/bash

fileName="system/meshQualityDict"
minFaceWeight=0.02
maxNonOrtho=65
maxBoundarySkewness=20
maxInternalSkewness=4
maxConcave=80
minVol=1e-13
minTetQuality=1e-15
minArea=-1
minTwist=0.02
minDeterminant=0.001
minFaceWeight=0.05
minVolRatio=0.01
minTriangleTwist=-1

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
echo "    object      meshQualityDict;"  	>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "minFaceWeight $minFaceWeight;" 				>> "$fileName"
echo "maxNonOrtho $maxNonOrtho;" 					>> "$fileName"
echo "maxBoundarySkewness $maxBoundarySkewness;" 	>> "$fileName"
echo "maxInternalSkewness $maxInternalSkewness;" 	>> "$fileName"
echo "maxConcave $maxConcave;" 						>> "$fileName"
echo "minVol $minVol;" 								>> "$fileName"
echo "minTetQuality $minTetQuality;" 				>> "$fileName"
echo "minArea $minArea;" 							>> "$fileName"
echo "minTwist $minTwist;" 							>> "$fileName"
echo "minDeterminant $minDeterminant;" 				>> "$fileName"
echo "minFaceWeight $minFaceWeight;" 				>> "$fileName"
echo "minVolRatio $minVolRatio;" 					>> "$fileName"
echo "minTriangleTwist $minTriangleTwist;" 			>> "$fileName"