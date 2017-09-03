#!/bin/bash
###############################################################################
# PARAMETERS ==================================================================
GET_GULL=1;
GET_XS=1;
GET_GOOSE=1;
RUN_XS=1;
RUN_GULL=1;
###############################################################################
# GET GOOSE ===================================================================
if [[ "$GET_GOOSE" -eq "1" ]]; then
  rm -fr goose-*;
  git clone https://github.com/pratas/goose.git
  cd goose/src/
  make
  cd ../../
  cp goose/src/goose-* .
fi
###############################################################################
# GET GULL ====================================================================
if [[ "$GET_GULL" -eq "1" ]]; then
  rm -fr GULL-*;
  git clone https://github.com/pratas/GULL.git
  cd GULL/src/
  cmake .
  make
  cd ../../
  cp GULL/src/GULL-* .
fi
###############################################################################
# GET XS ======================================================================
if [[ "$GET_XS" -eq "1" ]]; then
  rm -fr XS*;
  git clone https://github.com/pratas/xs.git
  cd xs/
  make
  cd ../
  cp xs/XS .
fi
###############################################################################
# RUN XS ======================================================================
if [[ "$RUN_XS" -eq "1" ]]; then
  PMIN=0;
  PMAX=20;
  JUMP=1;
  ./XS -v -ls 1000 -n 5000 -f 0.25,0.25,0.25,0.25,0 -eh -eo -edb -es -s 0 SAMPLE
  for((x=$PMIN ; x<=$PMAX ; x+=$JUMP));
    do
    echo "Permutation rate: $x";
    MRATE=`echo "scale=3;$x/100" | bc -l`;
    ./goose-permuteseqbyblocks -bs 100 -s 101 < SAMPLE > SAMPLE$x.perm
    ./goose-mutatedna -mr $MRATE < SAMPLE$x.perm > SAMPLE$x.mut
    done
fi
###############################################################################
# RUN GULL ====================================================================
if [[ "$RUN_GULL" -eq "1" ]]; then
  ./GULL-map -v -n 4 -l 10 -c 10 -x Matrix.csv SAMPLE0.mut:SAMPLE1.mut:SAMPLE2.mut:SAMPLE3.mut:SAMPLE4.mut:SAMPLE5.mut:SAMPLE6.mut:SAMPLE7.mut:SAMPLE8.mut:SAMPLE9.mut:SAMPLE10.mut:SAMPLE11.mut:SAMPLE12.mut:SAMPLE13.mut:SAMPLE14.mut:SAMPLE15.mut:SAMPLE16.mut:SAMPLE17.mut:SAMPLE18.mut:SAMPLE19.mut:SAMPLE20.mut
  ./GULL-visual -v -x SynMap.svg Matrix.csv
fi
###############################################################################






















