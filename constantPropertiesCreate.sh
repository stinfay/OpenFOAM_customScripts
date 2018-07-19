#!/bin/bash

fileName="constant/turbulenceProperties"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "FoamFile" >> "$fileName"
echo "{" >> "$fileName"
echo "    version     2.0;" >> "$fileName"
echo "    format      ascii;" >> "$fileName"
echo "    class       dictionary;" >> "$fileName"
echo "    object      turbulenceProperties;" >> "$fileName"
echo "}" >> "$fileName"

echo "" >> "$fileName"

echo "simulationType RAS;" >> "$fileName"
echo "RAS" >> "$fileName"
echo "{" >> "$fileName"
echo "    RASModel kOmegaSST;" >> "$fileName"
echo "    turbulence on;" >> "$fileName"
echo "    printCoeffs on;" >> "$fileName"
echo "}" >> "$fileName"

##########################################################################################

fileName="constant/transportProperties"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "" >> "$fileName"

echo "FoamFile" >> "$fileName"
echo "{" >> "$fileName"
echo "    version     2.0;" >> "$fileName"
echo "    format      ascii;" >> "$fileName"
echo "    class       dictionary;" >> "$fileName"
echo "    object      transportProperties;" >> "$fileName"
echo "}" >> "$fileName"

echo "transportModel Newtonian;" >> "$fileName"
echo "nu [0 2 -1 0 0 0 0] 1.5e-05;" >> "$fileName"