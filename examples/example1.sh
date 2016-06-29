#!/bin/bash
###############################################################################
# REQUIREMENTS: linux OS with cmake & git
# IT USES 12 THREADS & 6 GB OF RAM
###############################################################################
# PARAMETERS ==================================================================
INSTALL=1;
DOWNLOAD=1;
GULL=1;
VISUAL=1;
PARAM=" -m 20:100:1:3/10 -m 13:100:1:0/0 -m 4:1:0:0/0 -c 35 -g 0.95 ";
###############################################################################
if [[ "$INSTALL" -eq "1" ]]; then
# CLEAN & INSTALL =============================================================
rm -fr goose-* GULL-map GULL-visual goose/ GULL/
# GET GOOSE FRAMEWORK =========================================================
git clone https://github.com/pratas/goose.git
cd goose/src/
make
cd ../../
cp goose/src/goose-* .
cp goose/scripts/Get* .
# GET GULL ====================================================================
git clone https://github.com/pratas/GULL.git
cd GULL/src/
cmake .
make
cp GULL-map ../../
cp GULL-visual ../../
cd ../../
fi
###############################################################################
if [[ "$DOWNLOAD" -eq "1" ]]; then
. GetHumanParse.sh
. GetGorillaParse.sh
. GetCapraHircus.sh
fi
###############################################################################
if [[ "$GULL" -eq "1" ]]; then
(time ./GULL-map -v $PARAM -n 12 -x MATRIX -o LABELS HS1:HS2:HS3:HS4:HS5:HS6:HS7:HS8:HS9:HS10:HS11:HS12:HS13:HS14:HS15:HS16:HS17:HS18:HS19:HS20:HS21:HS22:HS23:HS24:HS25:HS26:HS27:GG1:GG2A:GG2B:GG3:GG4:GG5:GG6:GG7:GG8:GG9:GG10:GG11:GG12:GG13:GG14:GG15:GG16:GG17:GG18:GG19:GG20:GG21:GG22:GG23:GG24:GG25:CHIR1:CHIR2:CHIR3:CHIR4:CHIR5:CHIR6:CHIR7:CHIR8:CHIR9:CHIR10:CHIR11:CHIR12:CHIR13:CHIR14:CHIR15:CHIR16:CHIR17:CHIR18:CHIR19:CHIR20:CHIR21:CHIR22:CHIR23:CHIR24:CHIR25:CHIR26:CHIR27:CHIR28:CHIR29:CHIR30:CHIR31:CHIR32 ) &> REPORT
fi
###############################################################################
if [[ "$VISUAL" -eq "1" ]]; then
./GULL-visual -v -l LABELS -x HEATMAP.svg MATRIX
fi
###############################################################################
