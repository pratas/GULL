#!/bin/bash
###############################################################################
# REQUIREMENTS: linux OS with cmake & git
# IT USES 14 THREADS & 8 GB OF RAM
###############################################################################
# PARAMETERS ==================================================================
INSTALL=1;
DOWNLOAD=1;
GULL=1;
VISUAL=1;
PARAM=" -m 20:100:1:3/10 -m 14:100:1:0/0 -m 4:1:0:0/0 -c 35 -g 0.95 ";
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
make clean; make;
cp GULL-map ../../
cp GULL-visual ../../
cd ../../
fi
###############################################################################
if [[ "$DOWNLOAD" -eq "1" ]]; then
#bact&vir
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Enterobacter_cloacae/reference/GCF_000025565.1_ASM2556v1/GCF_000025565.1_ASM2556v1_genomic.fna.gz -O EN_CO.gz
gunzip EN_CO.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Escherichia_coli/reference/GCF_000008865.1_ASM886v1/GCF_000008865.1_ASM886v1_genomic.fna.gz -O ES_CO.gz
gunzip ES_CO.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Salmonella_enterica/reference/GCF_000006945.1_ASM694v1/GCF_000006945.1_ASM694v1_genomic.fna.gz -O SA_EN.gz
gunzip SA_EN.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Mycobacterium_tuberculosis/reference/GCF_000195955.2_ASM19595v2/GCF_000195955.2_ASM19595v2_genomic.fna.gz -O MY_TU.gz
gunzip MY_TU.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Neisseria_gonorrhoeae/reference/GCF_000006845.1_ASM684v1/GCF_000006845.1_ASM684v1_genomic.fna.gz -O NI_GO.gz
gunzip NI_GO.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/Avian_carcinoma_virus/latest_assembly_versions/GCF_000849005.1_ViralProj14632/GCF_000849005.1_ViralProj14632_genomic.fna.gz -O AV_CA.gz
gunzip AV_CA.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/Bacillus_phage_Bam35/latest_assembly_versions/GCF_000841545.1_ViralProj14311/GCF_000841545.1_ViralProj14311_genomic.fna.gz -O BA_PH.gz
gunzip BA_PH.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/Enterobacteria_phage_phiX174_sensu_lato/latest_assembly_versions/GCF_000819615.1_ViralProj14015/GCF_000819615.1_ViralProj14015_genomic.fna.gz -O EN_PH.gz
gunzip EN_PH.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/Baminivirus/latest_assembly_versions/GCF_000917875.1_ViralProj242951/GCF_000917875.1_ViralProj242951_genomic.fna.gz -O BA_VI.gz
gunzip BA_VI.gz
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/Citrus_tristeza_virus/latest_assembly_versions/GCF_000862265.1_ViralProj15334/GCF_000862265.1_ViralProj15334_genomic.fna.gz -O CI_TR.gz
gunzip CI_TR.gz
#birds
wget ftp://climb.genomics.cn/pub/10.5524/101001_102000/101009/Cuculus_canorus.fa.gz -O CU_CA.gz
gunzip CU_CA.gz
wget ftp://climb.genomics.cn/pub/10.5524/101001_102000/101006/peregrine.FG.2011.0223_sca.bk.fa -O FA_PE
wget ftp://climb.genomics.cn/pub/10.5524/101001_102000/101040/Haliaeetus_leucocephalus.fa.gz -O HA_LE.gz
gunzip HA_LE.gz
wget ftp://climb.genomics.cn/pub/10.5524/101001_102000/101027/Haliaeetus_albicilla.fa.gz -O HA_AL.gz
gunzip HA_AL.gz
#
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
(time ./GULL-map -v $PARAM -n 14 -x MATRIX -o LABELS HS1:HS2:HS3:HS4:HS5:HS6:HS7:HS8:HS9:HS10:HS11:HS12:HS13:HS14:HS15:HS16:HS17:HS18:HS19:HS20:HS21:HS22:HSX:HSY:HS_UL:HS_UP:HS_MT:GG1:GG2A:GG2B:GG3:GG4:GG5:GG6:GG7:GG8:GG9:GG10:GG11:GG12:GG13:GG14:GG15:GG16:GG17:GG18:GG19:GG20:GG21:GG22:GGX:GG_UP:GG_MT:CH3:CH4:CH16:CH18:EN_CO:ES_CO:SA_EN:MY_TU:NI_GO:AV_CA:BA_PH:EN_PH:BA_VI:CI_TR:CU_CA:FA_PE:HA_LE:HA_AL ) &> REPORT
fi
###############################################################################
if [[ "$VISUAL" -eq "1" ]]; then
./GULL-visual -v -l LABELS -x HEATMAP.svg MATRIX
###############################################################################
convert HEATMAP.svg HEATMAP.pdf
###############################################################################

