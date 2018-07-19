#!/bin/bash

find -P /home/justin/OpenFOAM/OpenFOAM-4.1/OpenFOAM_customScripts/ -name "*.sh" -exec chmod 555 {} \;
find -P /home/justin/OpenFOAM/OpenFOAM-4.1/OpenFOAM_customScripts/ -name "*.sh" -exec ln -Pf {} /home/justin/OpenFOAM/OpenFOAM-4.1/bin/ \;