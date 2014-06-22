Getting and Cleaning Data
==============================================================================
Course Project, Coursera, June 2014
-----------------------------------
CodeBook
--------
This project consists of a script called run_analysis.R, that consumes a 
dataset of measurements made with a Samsung mobile device and produces a tidy
dataset as output.

run_analysis.R is required to perform the following tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Input Data
==========
I will not go into full detail here because it is already described in 
detail in two text files which are included in inData folder

1. README.txt: this is the entry point to understand the contents of all the other files.
2. features_info.txt: a codebook-like description of the variables.

The following aspects of the input dataset are worth documenting because
they are relevant to understanding how the script works:

 - **features.txt:** 2-column vector, associates the sequential order of each variable in the training set (X_train.txt) to a short name, which is composed mainly of 3 parts: MEASSUREMENT-FUNCTION-DIRECTION, where FUNCTION is the function used to calculate the variable out from the raw data, and we are interested in names containing:
  - mean/Mean
  - std
  
 - **activity_labels.txt:** 2-column vector, associates a numeric id to the name of the activity 
  
 - **train:** directory, contains the training set (70% of subjects)
The root folder contains following data:
  - A 561-feature vector with time and frequency domain variables. 
  - Its activity label. 
  - An identifier of the subject who carried out the experiment.
  
 - **train\X_train.txt:**  561-column vector, the variables of the training set, 2947 rows
  
 - **train\Y_train.txt:**  1-column, (labels) the activity corresponding to each row in X_train.txt, 2947 rows
  
 - **train\subject_train.txt:** 1-column vector, identifies the person origin of each data row in X_train.txt, 2947 rows
  
 - **test:** directory, contains the test set, the contents are identical in structure to the training set (30% of the subjects)

Note that the raw data variables from the input dataset are not needed for this 
project and can be ignored.


Output Data
===========
**outData/X_mean_activity_subject.txt: **

The output data consists of a tab-separated text file, with headers.   The table contains the means, grouped by subject and activity, of a subset of variables from the input dataset, which in turn represent normalized means and standard deviations of the measurements.

Following is the list of the 88 columns found in the output dataset:

Labels
------
 - **activityName:**  the name of the activity that the subject was performing when the massurements were recorded.
 - **subjectId:**  a consecutive integer in the [1-30] range that identifies the subject who performed the activity.

Features: (86 variables)
---------
The values are averages of the input data values, grouped by the two labels above.

Please refer to the features_info.txt file in the input data set for details on
the naming convention (the meaning of each name)
The names of the variables from the input dataset has been preserved, with minimal
modification to remove special characters which are not well suited to be used as
variable names in a programming language.

  tBodyAcc_mean_X	
  tBodyAcc_mean_Y	
  tBodyAcc_mean_Z	
  tBodyAcc_std_X	
  tBodyAcc_std_Y	
  tBodyAcc_std_Z	
  tGravityAcc_mean_X	
  tGravityAcc_mean_Y	
  tGravityAcc_mean_Z	
  tGravityAcc_std_X	
  tGravityAcc_std_Y	
  tGravityAcc_std_Z	
  tBodyAccJerk_mean_X	
  tBodyAccJerk_mean_Y	
  tBodyAccJerk_mean_Z	
  tBodyAccJerk_std_X	
  tBodyAccJerk_std_Y	
  tBodyAccJerk_std_Z	
  tBodyGyro_mean_X	
  tBodyGyro_mean_Y	
  tBodyGyro_mean_Z	
  tBodyGyro_std_X	
  tBodyGyro_std_Y	
  tBodyGyro_std_Z	
  tBodyGyroJerk_mean_X	
  tBodyGyroJerk_mean_Y	
  tBodyGyroJerk_mean_Z	
  tBodyGyroJerk_std_X	
  tBodyGyroJerk_std_Y	
  tBodyGyroJerk_std_Z	
  tBodyAccMag_mean	
  tBodyAccMag_std	
  tGravityAccMag_mean	
  tGravityAccMag_std	
  tBodyAccJerkMag_mean	
  tBodyAccJerkMag_std	
  tBodyGyroMag_mean	
  tBodyGyroMag_std	
  tBodyGyroJerkMag_mean	
  tBodyGyroJerkMag_std	
  fBodyAcc_mean_X	
  fBodyAcc_mean_Y	
  fBodyAcc_mean_Z	
  fBodyAcc_std_X	
  fBodyAcc_std_Y	
  fBodyAcc_std_Z	
  fBodyAcc_meanFreq_X	
  fBodyAcc_meanFreq_Y	
  fBodyAcc_meanFreq_Z	
  fBodyAccJerk_mean_X	
  fBodyAccJerk_mean_Y	
  fBodyAccJerk_mean_Z	
  fBodyAccJerk_std_X	
  fBodyAccJerk_std_Y	
  fBodyAccJerk_std_Z	
  fBodyAccJerk_meanFreq_X	
  fBodyAccJerk_meanFreq_Y	
  fBodyAccJerk_meanFreq_Z	
  fBodyGyro_mean_X	
  fBodyGyro_mean_Y	
  fBodyGyro_mean_Z	
  fBodyGyro_std_X	
  fBodyGyro_std_Y	
  fBodyGyro_std_Z	
  fBodyGyro_meanFreq_X	
  fBodyGyro_meanFreq_Y	
  fBodyGyro_meanFreq_Z	
  fBodyAccMag_mean	
  fBodyAccMag_std	
  fBodyAccMag_meanFreq	
  fBodyBodyAccJerkMag_mean	
  fBodyBodyAccJerkMag_std	
  fBodyBodyAccJerkMag_meanFreq	
  fBodyBodyGyroMag_mean	
  fBodyBodyGyroMag_std	
  fBodyBodyGyroMag_meanFreq	
  fBodyBodyGyroJerkMag_mean	
  fBodyBodyGyroJerkMag_std	
  fBodyBodyGyroJerkMag_meanFreq	
  angletBodyAccMean.gravity	
  angletBodyAccJerkMean.gravityMean	
  angletBodyGyroMean.gravityMean	
  angletBodyGyroJerkMean.gravityMean	
  angleX.gravityMean	
  angleY.gravityMean	
  angleZ.gravityMean


Script run_analysis.R
=====================
Please find instructions to run in README.md

Description of the run_analysis.R script:
-----------------------------------------
The script consists of two parts, a function that reads and subsets a
dataset, and a main section that calls the function with each dataset
and then combines and summarizes the results.

Main section
------------
Calls the function getXMeanStd(), once for each dataset (Test and Train) then combines the resulting data frames, summarizes and writes the output file.
 
The following steps describe the main section of the script

1. Call function to read and subset the Test dataset
2. Call function to read and subset the Train dataset
3. Append rows from the two datasets read above
4. Calculates the average of each variable, by activity and subject
5. Writes the summarized data to the output file in the outData directory

function GetXMeanStd()
----------------------
Reads the X values (variable values), fixes the names, add label columns, and select a subset of the variables.
 
Params
 - xFile          path to the file that contains the X vector
 - featureFile    path to the features.txt file 
 - yFile          path to the file that contains the y label vector
 - activityFile   path to the activities.txt file
 - subjectFile    path to the file that contains the subject variable
 
The following is the list of steps performed by this function:
  1. Read X_test.txt
  2. Read features.txt
  3. Assign names to the variables, from the features.txt content
  4. Remove special chars [-+()] from the variables' names
  5. Subset the data frame, keeping only those columns containing "std" or "mean" in the name
  6. Read label ids from y_test.txt
  7. Read activity_labels.txt
  8. Merge y with activity
  9. Add the activityName column to the variables data frame 
  10. Read subject_test.txt
  11. Add the subjectId variables data frame, as a factor to avoid inclusion in subsequent summarisation



     