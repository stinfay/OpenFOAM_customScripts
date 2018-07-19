
mkdir 0
mkdir 0/include

velX=$1
velY=$2
velZ=$3
turbulentKE=0.24
turbulentOmega=1.78

fileName="0/U"

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
echo "    class       volVectorField;"      >> "$fileName"
echo "    location    \"0\";" 				>> "$fileName"
echo "    object      U;"  					>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "#include \"include/initialConditions\"" >> "$fileName"
echo "dimensions [0 1 -1 0 0 0 0];" >> "$fileName"
echo "internalField uniform \$flowVelocity;" >> "$fileName"
echo "boundaryField" >> "$fileName"
echo "{" >> "$fileName"
echo "    #includeEtc \"caseDicts/setConstraintTypes\"" >> "$fileName"
echo "    #include \"include/fixedInlet\"" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type inletOutlet;" >> "$fileName"
echo "        inletValue uniform (0 0 0);" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    stlModelGroup" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type noSlip;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    #include \"include/frontBackUpperLowerPatches\"" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/p"

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
echo "    class       volScalarField;"      >> "$fileName"
echo "    object      p;"  					>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "#include \"include/initialConditions\"" >> "$fileName"
echo "dimensions [0 2 -2 0 0 0 0];" >> "$fileName"
echo "internalField uniform \$pressure;" >> "$fileName"
echo "boundaryField" >> "$fileName"
echo "{" >> "$fileName"
echo "    #includeEtc \"caseDicts/setConstraintTypes\"" >> "$fileName"
echo "    inlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type zeroGradient;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type fixedValue;" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    stlModelGroup" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type zeroGradient;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    #include \"include/frontBackUpperLowerPatches\"" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/omega"

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
echo "    class       volScalarField;"      >> "$fileName"
echo "    location    \"0\";" 				>> "$fileName"
echo "    object      omega;"  				>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "#include \"include/initialConditions\"" >> "$fileName"
echo "dimensions [0 0 -1 0 0 0 0];" >> "$fileName"
echo "internalField uniform \$turbulentOmega;" >> "$fileName"
echo "boundaryField" >> "$fileName"
echo "{" >> "$fileName"
echo "    #includeEtc \"caseDicts/setConstraintTypes\"" >> "$fileName"
echo "    #include \"include/fixedInlet\"" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type inletOutlet;" >> "$fileName"
echo "        inletValue \$internalField;" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    stlModelGroup" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type omegaWallFunction;" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    #include \"include/frontBackUpperLowerPatches\"" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/nut"

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
echo "    class       volScalarField;"      >> "$fileName"
echo "    location    \"0\";" 				>> "$fileName"
echo "    object      nut;"  				>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "dimensions [0 2 -1 0 0 0 0];" >> "$fileName"
echo "internalField uniform 0;" >> "$fileName"
echo "boundaryField" >> "$fileName"
echo "{" >> "$fileName"
echo "    #includeEtc \"caseDicts/setConstraintTypes\"" >> "$fileName"
echo "    frontAndBack" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type calculated;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    inlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type calculated;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type calculated;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    lowerWall" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type calculated;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    upperWall" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type calculated;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    stlModelGroup" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type nutkWallFunction;" >> "$fileName"
echo "        value uniform 0;" >> "$fileName"
echo "    }" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/k"

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
echo "    class       volScalarField;"      >> "$fileName"
echo "    object      k;"  					>> "$fileName"
echo "}"                                	>> "$fileName"

echo "" >> "$fileName"

echo "#include \"include/initialConditions\"" >> "$fileName"
echo "dimensions [0 2 -2 0 0 0 0];" >> "$fileName"
echo "internalField uniform \$turbulentKE;" >> "$fileName"
echo "boundaryField" >> "$fileName"
echo "{" >> "$fileName"
echo "    #includeEtc \"caseDicts/setConstraintTypes\"" >> "$fileName"
echo "    #include \"include/fixedInlet\"" >> "$fileName"
echo "    outlet" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type inletOutlet;" >> "$fileName"
echo "        inletValue \$internalField;" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    stlModelGroup" >> "$fileName"
echo "    {" >> "$fileName"
echo "        type kqRWallFunction;" >> "$fileName"
echo "        value \$internalField;" >> "$fileName"
echo "    }" >> "$fileName"
echo "    #include \"include/frontBackUpperLowerPatches\"" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/include/fixedInlet"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "" >> "$fileName"
echo "inlet" >> "$fileName"
echo "{" >> "$fileName"
echo "    type fixedValue;" >> "$fileName"
echo "    value \$internalField;" >> "$fileName"
echo "}" >> "$fileName"

###############################################################################################

fileName="0/include/initialConditions"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "" >> "$fileName"

echo "flowVelocity ($velX $velY $velZ);" >> "$fileName"
echo "pressure 0;" >> "$fileName"
echo "turbulentKE $turbulentKE;" >> "$fileName"
echo "turbulentOmega $turbulentOmega;" >> "$fileName"

###############################################################################################

fileName="0/include/frontBackUpperLowerPatches"

echo "/*--------------------------------*- C++ -*------------------------*\\"  > "$fileName"
echo "|  F ield         | OpenFOAM: The Open Source CFD Toolbox           |"  >> "$fileName"
echo "|  O peration     | Version:  4.x                                   |"  >> "$fileName"
echo "|  A nd           | Web:      www.OpenFOAM.org                      |"  >> "$fileName"
echo "|  M anipulation  |                                                 |"  >> "$fileName"
echo "\\*-----------------------------------------------------------------*/" >> "$fileName"

echo "" >> "$fileName"

echo "upperWall" >> "$fileName"
echo "{" >> "$fileName"
echo "    type slip;" >> "$fileName"
echo "}" >> "$fileName"
echo "lowerWall" >> "$fileName"
echo "{" >> "$fileName"
echo "    type slip;" >> "$fileName"
echo "}" >> "$fileName"
echo "frontAndBack" >> "$fileName"
echo "{" >> "$fileName"
echo "    type slip;" >> "$fileName"
echo "}" >> "$fileName"



