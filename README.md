==================================================================
Getting and Cleaning Data 
Coursera, June 2014
Course Project
==================================================================
Code Repository:   https://github.com/adsar/GettingAndCleaning
==================================================================

The repository contains the following files:
-------------------------------------------
README.md
  top-level description of file contents, including the processing
  steps performed and where to find descriptions of input and output datasets.

CookBook.md
  describes the variables, and the data transformations or work 
  performed to clean up the data

run_analysis.R
  The script run_analysis.R is self-contained, in the sense that it
  does not call other scripts.

  Instructions to Run the script in R:
  1. Ensure that the working directory is set to the same local
     folder where the script file is found.
  2. Ensure that the current directory contains and inData 
     subdirectory.
  3. Copy the content of the run_analysis.R file, paste it on
     the RStudio console, and press Enter.
     It should take 30 seconds to a minute, depending on the
     hardware.
  4. To see the result, open the file
     ./outData/X_mean_activity_subject.txt
  
  For a step-wise description of the inner working of the script, 
  please refer to CodeBook.md.

data
  directory containing the Samsung dataset

outData 
  this is the tidy dataset produced by the R script (output data)

See CodeBook.md for details on the input and output datasets.

