#!/bin/bash

endTime=$1
deltaT=$2
writeInterval=$3

fileName="system/controlDict"

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
echo "    object      controlDict;"   	>> "$fileName"
echo "}"                                >> "$fileName"

echo "" >> "$fileName"

echo "application simpleFoam;"			>> "$fileName"
echo "startFrom latestTime;" 			>> "$fileName"
echo "startTime 0;" 					>> "$fileName"
echo "stopAt endTime;" 					>> "$fileName"
echo "endTime $endTime;" 				>> "$fileName"
echo "deltaT $deltaT;" 					>> "$fileName"
echo "writeControl timeStep;" 			>> "$fileName"
echo "writeInterval $writeInterval;" 	>> "$fileName"
echo "purgeWrite 0;" 					>> "$fileName"
echo "writeFormat binary;" 				>> "$fileName"
echo "writePrecision 6;" 				>> "$fileName"
echo "writeCompression uncompressed;" 	>> "$fileName"
echo "timeFormat general;" 				>> "$fileName"
echo "timePrecision 12;" 				>> "$fileName"
echo "runTimeModifiable true;" 			>> "$fileName"

