<p align="center"><img src="imgs/logo.png" 
alt="smash-global" width="200" height="200" border="0" /></p>

Smash-global is an alignment-free unsupervised tool to measure and visualise similarity between genomic sequences.

## INSTALLATION ##

Cmake is needed for installation (http://www.cmake.org/). You can download it directly from http://www.cmake.org/cmake/resources/software.html or use an appropriate packet manager. In the following instructions we show the procedure to install smash-global:
<pre>
git clone https://github.com/pratas/smash-global.git
cd smash-global/src/
cmake .
make
cp smash-global-map ../../
cp smash-global-visual ../../
cd ../../
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
For smash-global-map:
<pre>
Usage: smash-global-map [OPTION]... [FILE1]:[FILE2]:...                  
A similarity matrix builder using relative information.                  
                                                                         
Non-mandatory arguments:                                                 
                                                                         
  -h                       give this help,                               
  -V                       display version number,                       
  -v                       verbose mode (more information),              
  -s                       how compression levels,                       
  -l &#60level&#62               compression level [1;30],                     
  -n &#60nThreads&#62            number of threads,                            
  -x &#60FILE&#62                similarity matrix filename,                   
  -o &#60FILE&#62                labels filename,                              
                                                                         
Mandatory arguments:                                                     
                                                                         
  &#60FILE&#62:&#60FILE&#62:&#60...&#62      input files (last arguments).                 
                           Use ":" for file splitting.                 
                                                                         
Report bugs to &#60{pratas,ap,pjf}@ua.pt&#62.                
</pre>
For smash-global-visual:
<pre>
Usage: smash-global-visual [OPTION]... [FILE]                            
A visual heatmap builder for any similarity matrix.                      
                                                                         
Non-mandatory arguments:                                                 
                                                                         
  -h                       give this help,                               
  -V                       display version number,                       
  -v                       verbose mode (more information),              
  -w                       square width (for each value),                
  -a                       square inter-space (between each value),      
  -s                       index color start,                            
  -r                       index color rotations,                        
  -u                       color hue,                                    
  -g                       color gamma,                                  
  -l &#60FILE&#62                labels filename,                              
  -x &#60FILE&#62                heatmap filename,                             
                                                                         
Mandatory arguments:                                                     
                                                                         
  &#60FILE&#62                   input matrix file (last argument).            
                                                                         
Report bugs to &#60{pratas,ap,pjf}@ua.pt&#62.   
</pre>

## CITATION ##

On using this software/method please cite:

Paper submitted.

## ISSUES ##

For any issue let us know at [issues link](https://github.com/pratas/smash-global/issues).

## LICENSE ##

GPL v3.

For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>

