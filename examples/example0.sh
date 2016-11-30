#!/bin/bash
###############################################################################
INSTALL_GDC2=0;
INSTALL_IDOCOMP=0;
INSTALL_GREEN=0;
INSTALL_GECO=0;
###############################################################################
DOWNLOAD=0;
PARSE=0;
###############################################################################
RUN_GDC2=0;
RUN_IDOCOMP=0;
RUN_GREEN=0;
RUN_GECO=0;
###############################################################################
RUN_PLOT=1;
###############################################################################
#
function Parse {
  zcat $1.fa.gz | grep -v ">" | tr -d -c "ACGT" > XTMP
  cat HEADER XTMP > datasets/$1;
  }
#
function RunGDC2 {
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  rm -f xxx*
  (time ./GDC2 c xxx $2 $1 ) &> ../../results/C_GDC_$1-$2
  ls -la xxx.gdc2_rc | awk '{ print $5;}' > ../../results/BC_GDC_$1-$2
  rm -f $2 $1;
  }
#
function RunGReEn {
  PARAM=" -v " # -i -k 16 -f 5 ";
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  rm -f $1.co
  (time ./GReEnC $PARAM -o $1.co $2 $1 ) &> ../../results/C_GREEN_$1-$2
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GREEN_$1-$2
  rm -f $2 $1;
  }
#
function RunGeCo {
  PARAM=" -v -rm 20:500:1:3/100 -rm 13:200:1:0/0 -rm 10:10:0:0/0 -c 35 -g 0.95 ";
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  rm -f $1.co
  (time ./GeCo $PARAM -r $2 $1 ) &> ../../results/C_GECO_REF_$1-$2
  ls -la $1.co | awk '{ print $5;}' > ../../results/BC_GECO_REF_$1-$2
  rm -f $2 $1;
  }
#
function RunIDoComp {
  # 1 - TARGET
  # 2 - REFERENCE
  cp ../../datasets/$1 .
  cp ../../datasets/$2 .
  cd sais-lite-2.4.1/
  rm -fr sa ref tar
  mkdir sa ref tar;
  cp ../$2 ref/$2.fa
  (./generateSA.sh ref sa ) &> TIME_SA
  TIMEOFSA=`cat TIME_SA | grep "..." | awk '{ print $5;}'`
  mv ../$1 tar/$1.fa
  echo "ref/$2.fa tar/$1.fa sa/$2.sa" > f.txt;
  cp ../simulations/iDoComp.run .
  (./iDoComp.run c f.txt OUT ) &> ../../../results/C_IDOCOMP_$1-$2
  cat ../../../results/C_IDOCOMP_$1-$2 | grep "Compressed Size:" | awk '{ print $3; }' > ../../../results/BC_IDOCOMP_$1-$2
  CTIME=`cat ../../../results/C_IDOCOMP_$1-$2 | grep "CPU T" | awk '{ print $4;}'`
  echo "$TIMEOFSA+$CTIME" | bc -l > ../../../results/CT_IDOCOMP_$1-$2
  rm -f $2 $1;
  cd ..
  }
#
###############################################################################
# INSTALL
mkdir -p datasets
mkdir -p progs
cd progs/
###############################################################################
# GET iDoComp =================================================================
if [[ "$INSTALL_IDOCOMP" -eq "1" ]]; then
  rm -fr iDoComp_website_v1*
  wget http://web.stanford.edu/~iochoa/iDoComp_website_v1.tar.gz
  tar -xvzf iDoComp_website_v1.tar.gz
  cd iDoComp_website_v1/sais-lite-2.4.1/source-code/
  gcc -o ../sa.run sa_generator.c sais.c -lm
  cd ../../
  cd simulations/source_code/
  gcc -o ../iDoComp.run idc_generate_mapping.c main.c stats.c arith.c \
  fasta_decompressor.c idc_load_chr.c os_stream.c fasta_compressor.c \
  sam_stream.c -lm
  cd ../../../
  mv iDoComp_website_v1 idocomp
  rm -f iDoComp_website_v1.tar.gz
fi
###############################################################################
# GET GECO ====================================================================
if [[ "$INSTALL_GECO" -eq "1" ]]; then
  rm -fr geco/
  git clone https://github.com/pratas/geco.git
  cd geco/src/
  cmake .
  make
  cp GeCo ../
  cp GeDe ../
  cd ../../
fi
###############################################################################
# GET GREEN ===================================================================
if [[ "$INSTALL_GREEN" -eq "1" ]]; then
  rm -fr GReEn1.tar.gz green
  wget http://bioinformatics.ua.pt/wp-content/uploads/2014/09/GReEn1.tar.gz
  tar -xvzf GReEn1.tar.gz
  mv GReEn1/ green/
  cd green/
  make
  cd ..
  rm -fr GReEn1.tar.gz
fi
###############################################################################
# GET GDC =====================================================================
if [[ "$INSTALL_GDC2" -eq "1" ]]; then
  rm -f gdc2.tat.gz
  wget http://sun.aei.polsl.pl/REFRESH/gdc/downloads/2.0/gdc2.tar.gz
  tar -xzf gdc2.tar.gz
  cd gdc2/gdc_2/Gdc2/
  # LIBRARIES ORDER ACCESS CREATE SOME PROBLES (WE ADD THEM TO THE END)
  printf '\nall: gdc2 \n\nCC      = g++\nCFLAGS  = -Wall -O3 -m64 -Wl,--whole-archive -lpthread -Wl,--no-whole-archive -std=c++11 \nCLINK   = -lm -O3 -m64 -Wl,--whole-archive -lpthread -Wl,--no-whole-archive -std=c++11 -lz \n\n.cpp.o: \n\t$(CC) $(CFLAGS) -c $< -o $@ \n\ngdc2: c1stage.o c2stage.o fasta.o hasher.o main.o p1stage.o qsmodel.o queue.o rangecod.o timer.o \n\t$(CC) $(CLINK) -o gdc2 c1stage.o c2stage.o fasta.o hasher.o main.o p1stage.o qsmodel.o queue.o rangecod.o timer.o ../libs/libaelf64.a -lz -lpthread \n\nclean: \n\trm gdc2 \n\trm *.o \n' > Makefile;
  make clean ; make
  cp gdc2 ../../GDC2 # TO NOT OVERLAP FOLDER NAME
  cd ../../../
  rm -f gdc2.tar.gz
fi
##############################################################################
cd ..
###############################################################################
# DOWNLOAD
if [[ "$DOWNLOAD" -eq "1" ]]; then
  rm *.fa.gz -f
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr5.fa.gz -O HS5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr8.fa.gz -O HS8.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr11.fa.gz -O HS11.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr14.fa.gz -O HS14.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Homo_sapiens/Assembled_chromosomes/seq/hs_ref_GRCh38.p7_chr17.fa.gz -O HS17.fa.gz
  #
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chr5.fa.gz -O PT5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chr8.fa.gz -O PT8.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chr11.fa.gz -O PT11.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chr14.fa.gz -O PT14.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Pan_troglodytes/Assembled_chromosomes/seq/ptr_ref_Pan_tro_3.0_chr17.fa.gz -O PT17.fa.gz
  #
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/ggo_ref_gorGor3.1_chr5.fa.gz -O GG5.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/ggo_ref_gorGor3.1_chr8.fa.gz -O GG8.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/ggo_ref_gorGor3.1_chr11.fa.gz -O GG11.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/ggo_ref_gorGor3.1_chr14.fa.gz -O GG14.fa.gz
  wget ftp://ftp.ncbi.nlm.nih.gov/genomes/Gorilla_gorilla/Assembled_chromosomes/seq/ggo_ref_gorGor3.1_chr17.fa.gz -O GG17.fa.gz
  #
fi
# PARSE =======================================================================
if [[ "$PARSE" -eq "1" ]]; then
  echo "parsing ..."
  echo ">X" > HEADER
  #
  Parse "HS5"
  Parse "HS8"
  Parse "HS11"
  Parse "HS14"
  Parse "HS17"
  #
  Parse "PT5"
  Parse "PT8"
  Parse "PT11"
  Parse "PT14"
  Parse "PT17"
  #
  Parse "GG5"
  Parse "GG8"
  Parse "GG11"
  Parse "GG14"
  Parse "GG17"
  #
  echo "done!";
  fi
#
# RUN =========================================================================
if [[ "$RUN_GDC2" -eq "1" ]]; then
  echo "Running GDC2 ...";
  mkdir -p results
  cd progs/gdc2
  # target $1, reference $2:
  RunGDC2 "HS5" "PT5"
  RunGDC2 "HS5" "GG5"
  #
  RunGDC2 "HS8" "PT8"
  RunGDC2 "HS8" "GG8"
  #
  RunGDC2 "HS11" "PT11"
  RunGDC2 "HS11" "GG11"
  #
  RunGDC2 "HS14" "PT14"
  RunGDC2 "HS14" "GG14"
  #
  RunGDC2 "HS17" "PT17"
  RunGDC2 "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_IDOCOMP" -eq "1" ]]; then
  echo "Running iDoComp ...";
  mkdir -p results
  cd progs/idocomp
  # target $1, reference $2:
  RunIDoComp "HS5" "PT5"
  RunIDoComp "HS5" "GG5"
  #
  RunIDoComp "HS8" "PT8"
  RunIDoComp "HS8" "GG8"
  #
  RunIDoComp "HS11" "PT11"
  RunIDoComp "HS11" "GG11"
  #
  RunIDoComp "HS14" "PT14"
  RunIDoComp "HS14" "GG14"
  #
  RunIDoComp "HS17" "PT17"
  RunIDoComp "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_GECO" -eq "1" ]]; then
  echo "Running GeCo ...";
  mkdir -p results
  cd progs/geco
  # target $1, reference $2:
  RunGeCo "HS5" "PT5"
  RunGeCo "HS5" "GG5"
  #
  RunGeCo "HS8" "PT8"
  RunGeCo "HS8" "GG8"
  #
  RunGeCo "HS11" "PT11"
  RunGeCo "HS11" "GG11"
  #
  RunGeCo "HS14" "PT14"
  RunGeCo "HS14" "GG14"
  #
  RunGeCo "HS17" "PT17"
  RunGeCo "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
if [[ "$RUN_GREEN" -eq "1" ]]; then
  echo "Running GReEn ...";
  mkdir -p results
  cd progs/green
  # target $1, reference $2:
  RunGReEn "HS5" "PT5"
  RunGReEn "HS5" "GG5"
  #
  RunGReEn "HS8" "PT8"
  RunGReEn "HS8" "GG8"
  #
  RunGReEn "HS11" "PT11"
  RunGReEn "HS11" "GG11"
  #
  RunGReEn "HS14" "PT14"
  RunGReEn "HS14" "GG14"
  #
  RunGReEn "HS17" "PT17"
  RunGReEn "HS17" "GG17"
  # 
  cd ../../
  echo "Done!";
fi
#==============================================================================
###############################################################################
# PLOT
if [[ "$RUN_PLOT" -eq "1" ]]; then
rm -f DATAP;
printf "GReEn\t%s\n" `cat results/BC_GREEN_HS5-PT5 results/BC_GREEN_HS5-GG5 results/BC_GREEN_HS8-PT8 results/BC_GREEN_HS8-GG8 results/BC_GREEN_HS11-PT11 results/BC_GREEN_HS11-GG11 results/BC_GREEN_HS14-PT14 results/BC_GREEN_HS14-GG14 results/BC_GREEN_HS17-PT17 results/BC_GREEN_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAP
printf "iDoComp\t%s\n" `cat results/BC_IDOCOMP_HS5-PT5 results/BC_IDOCOMP_HS5-GG5 results/BC_IDOCOMP_HS8-PT8 results/BC_IDOCOMP_HS8-GG8 results/BC_IDOCOMP_HS11-PT11 results/BC_IDOCOMP_HS11-GG11 results/BC_IDOCOMP_HS14-PT14 results/BC_IDOCOMP_HS14-GG14 results/BC_IDOCOMP_HS17-PT17 results/BC_IDOCOMP_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAP
printf "GDC2\t%s\n" `cat results/BC_GDC_HS5-PT5 results/BC_GDC_HS5-GG5 results/BC_GDC_HS8-PT8 results/BC_GDC_HS8-GG8 results/BC_GDC_HS11-PT11 results/BC_GDC_HS11-GG11 results/BC_GDC_HS14-PT14 results/BC_GDC_HS14-GG14 results/BC_GDC_HS17-PT17 results/BC_GDC_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAP
printf "Proposed\t%s\n" `cat results/BC_GECO_REF_HS5-PT5 results/BC_GECO_REF_HS5-GG5 results/BC_GECO_REF_HS8-PT8 results/BC_GECO_REF_HS8-GG8 results/BC_GECO_REF_HS11-PT11 results/BC_GECO_REF_HS11-GG11 results/BC_GECO_REF_HS14-PT14 results/BC_GECO_REF_HS14-GG14 results/BC_GECO_REF_HS17-PT17 results/BC_GECO_REF_HS17-GG17 | awk '{s+=$1}END{print s}'` >> DATAP
fi
###############################################################################
echo "set terminal pdfcairo enhanced color
set output 'bytes.pdf'
set auto
set boxwidth 0.45
set xtics nomirror
set style fill solid 1.00
set ylabel 'Bytes'
set xlabel 'Methods'
set yrange[80000000:200000000]
# Lighter grid lines
set grid ytics lc rgb '#C0C0C0'
unset key
set grid
set format y '%.0s %c'
set style line 2 lc rgb '#406090'
plot 'DATAP' using 2:xtic(1) with boxes ls 2" | gnuplot -p
cp bytes.pdf ../imgs/

###############################################################################

