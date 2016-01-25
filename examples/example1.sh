#!/bin/bash
###############################################################################
# REQUIREMENTS: linux OS with cmake & git
###############################################################################
# PARAMETERS ==================================================================
INSTALL=1;
DOWNLOAD=1;
SMASH=1;
VISUAL=1;
PARAM=" -m 20:500:1:3/50 -m 14:100:1:0/0 -m 12:1:0:0/0 -m 4:1:0:0/0 \
-c 10 -g 0.95 ";
###############################################################################
if [[ "$INSTALL" -eq "1" ]]; then
# CLEAN & INSTALL =============================================================
rm -fr goose-* smash-global-* goose/ smash-global/
# GET GOOSE FRAMEWORK =========================================================
git clone https://github.com/pratas/goose.git
cd goose/src/
make
cd ../../
cp goose/src/goose-* .
cp goose/scripts/Get* .
# GET FALCON ==================================================================
git clone https://github.com/pratas/smash-global.git
cd smash-global/src/
cmake .
make
cp smash-global-map ../../
cp smash-global-visual ../../
cd ../../
fi
###############################################################################
if [[ "$DOWNLOAD" -eq "1" ]]; then
. GetHumanParse.sh
. GetCallithrixjacchus.sh
. GetCapraHircus.sh
fi
###############################################################################
