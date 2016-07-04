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
PARAM=" -m 20:500:1:3/50 -m 14:100:1:0/0 -m 6:1:0:0/0 -c 40 -g 0.95 ";
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
mv HS23 HSX
mv HS24 HSY
mv HS25 HS_UL
mv HS26 HS_UP
mv HS27 HS_MT
mv GG23 GGX
mv GG24 GG_UP
mv GG25 GG_MT
for((x=1 ; x<30 ; ++x));
 do
 mv CHIR$x CH$x;
 done
mv CHIR30 CHX
mv CHIR31 CH_UP
mv CHIR32 CH_MT
fi
###############################################################################
if [[ "$GULL" -eq "1" ]]; then
(time ./GULL-map -v $PARAM -n 12 -x MATRIX -o LABELS HS1:HS2:HS3:HS4:HS5:HS6:HS7:HS8:HS9:HS10:HS11:HS12:HS13:HS14:HS15:HS16:HS17:HS18:HS19:HS20:HS21:HS22:HSX:HSY:HS_UL:HS_UP:HS_MT:GG1:GG2A:GG2B:GG3:GG4:GG5:GG6:GG7:GG8:GG9:GG10:GG11:GG12:GG13:GG14:GG15:GG16:GG17:GG18:GG19:GG20:GG21:GG22:GGX:GG_UP:GG_MT:CH1:CH2:CH3:CH4:CH5:CH6:CH7:CH8:CH9:CH10:CH11:CH12:CH13:CH14:CH15:CH16:CH17:CH18:CH19:CH20:CH21:CH22:CH23:CH24:CH25:CH26:CH27:CH28:CH29:CHX:CH_UP:CH_MT ) &> REPORT
fi
###############################################################################
if [[ "$VISUAL" -eq "1" ]]; then
./GULL-visual -v -l LABELS -x HEATMAP.svg MATRIX
fi
###############################################################################
