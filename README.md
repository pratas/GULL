# SMASH-GLOBAL #

<p align="center"><img src="imgs/logo.png" 
alt="smash-global" width="200" height="200" border="0" /></p>

Smash-global is an alignment-free unsupervised tool to measure and visualise similarity between genomic sequences.

## INSTALLATION ##

Cmake is needed for installation (http://www.cmake.org/). You can download it directly from http://www.cmake.org/cmake/resources/software.html or use an appropriate packet manager. In the following instructions we show the procedure to install smash-global:
<pre>
wget https://github.com/pratas/smash-global/archive/master.zip
unzip master.zip
cd src/smash-global-master
cmake .
make
cp smash-global-map ..
cp smash-global-visual ..
cd ..
</pre>
This will create two binary files: 
<pre>
smash-global-map 
</pre>
to measure the similarity between sequences and
<pre>
smash-global-visual
</pre>
to visualise the similarity in a heatmap scheme.

## USAGE ##

To see the possible options type
<pre>
./smash-global-map
./smash-global-visual
</pre>
or
<pre>
./smash-global-map -h
./smash-global-visual -h
</pre>
These will print the parameters that are needed to run both tools.

## CITATION ##

On using this software/method please cite:

Diogo Pratas, Raquel M. Silva, Armando J. Pinho, Paulo J. S. G. Ferreira. An alignment-free method to find and visualise rearrangements between pairs of DNA sequences. Sci. Rep. 5, 10203; doi: 10.1038/srep10203 (2015).

## ISSUES ##

For any issue let us know at [issues link](https://github.com/pratas/smash-global/issues).

## LICENSE ##

GPL v2.

For more information:
<pre>http://www.gnu.org/licenses/gpl-2.0.html</pre>

