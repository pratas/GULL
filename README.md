<p align="center"><img src="imgs/logo.png" 
alt="GULL" width="200" height="200" border="0" /></p>

<b>GULL is an unsupervised tool for measuring relative similarity between non-assembled genomic sequences.</b>

## INSTALLATION ##

Cmake is needed for installation (http://www.cmake.org/). You can download it directly from http://www.cmake.org/cmake/resources/software.html or use an appropriate packet manager. In the following instructions we show the procedure to install GULL:
<pre>
git clone https://github.com/pratas/GULL.git
cd GULL/src/
cmake .
make
cp GULL-map ../../
cp GULL-visual ../../
cd ../../
</pre>
This will create two binary files: 
<pre>
GULL-map 
</pre>
to measure the similarity between sequences and
<pre>
GULL-visual
</pre>
to visualise the similarity in a heatmap scheme.

## USAGE ##

To see the possible options type
<pre>
./GULL-map
./GULL-visual
</pre>
or
<pre>
./GULL-map -h
./GULL-visual -h
</pre>
These will print the parameters that are needed to run both tools.

For GULL-map:
<pre>
Usage: GULL-map [OPTION]... [FILE1]:[FILE2]:...                  
A tool for measuring relative similarity between 
non-assembled genomic sequences without supervision.                                                                        
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
                                                                         
Report bugs to &#60{pratas,raquelsilva,ap,pjf}@ua.pt&#62.                
</pre>

For GULL-visual:
<pre>
Usage: GULL-visual [OPTION]... [FILE]                            
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
                                                                         
Report bugs to &#60{pratas,raquelsilva,ap,pjf}@ua.pt&#62.   
</pre>

## EXAMPLE ##

The following map shows and example while measuring similarity between human (HS), chimpanzee (PT) and gorilla (GG) chromosome sequences,
including unplaced (UP), unlocalized (UL) and mitocondrial (MT) sequences.

![ScreenShot](/imgs/mapHSPTGG.png)


## CITATION ##

On using this software/method please cite:

Paper submitted.

## ISSUES ##

For any issue let us know at [issues link](https://github.com/pratas/GULL/issues).

## LICENSE ##

GPL v3.

For more information:
<pre>http://www.gnu.org/licenses/gpl-3.0.html</pre>

