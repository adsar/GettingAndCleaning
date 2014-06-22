## run_analysis.R
## ---------------
## Course: Getting and Cleaning Data, Coursera, June 2014
## 
## Steps performed:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject. 
## ----------------------------------------------------------------------------

#==============================================================================
# function GetXMeanStd()
# reads a dataset, joins the tables, fixes the var names and subsets the cols.
# Params
# xFile          path to the file that contains the X vector
# featureFile    path to the features.txt file 
# yFile          path to the file that contains the y label vector
# activityFile   path to the activities.txt file 
# subjectFile    path to the file that contains the subject variable
#==============================================================================
getXMeanStd <- function(xFile, featureFile, yFile, activityFile, subjectFile){
  #01. Read X_test.txt
  x <-read.table(xFile, header=F)
  
  #  02. Read features.txt
  features <-read.table(featureFile, header=F)
  
  #  03. Assign names to teh variables, from the features.txt content
  colnames(x) <- features$V2
  
  #  04. Remove special chars [-+()] from the variables' names
  colnames(x) <- gsub( "\\-|\\+" , "_" , names(x))
  colnames(x) <- gsub( "\\s|\\," , "." , names(x))
  colnames(x) <- gsub( "\\(" , "" , names(x))
  colnames(x) <- gsub( "\\)" , "" , names(x))
  
  #  05. Subset the data frame, keeping only those columns containing "std"
  #  or "mean" in the name
  xMeanStd <- x[grepl("mean|Mean|std", names(x))]
  
  #  06. Read label ids from y_test.txt
  y <-read.table(yFile, header=F)
  
  #  07. Read activity_labels.txt
  activity <-read.table(activityFile, header=F)
  
  #  08. Merge y with activity
  y = merge(y, activity, by.x="V1", by.y="V1")
  
  #  09. Add the activityName column to the variables data frame 
  xMeanStd$activityName <- y$V2
  
  #  10. Read subject_test.txt
  subject <-read.table(subjectFile, header=F)
  
  #  11. Add the subjectId variables data frame, as a factor to avoid inclusion
  #  in subsequent summarisation
  xMeanStd$subjectId <- factor(subject$V1)
  
  xMeanStd
}

#==============================================================================
# Main script
# Calls a function to pre-process both dataset, then combines and summarizes.
#==============================================================================
# setwd("~/source/GettingAndCleaning")

#01. Call function to read and subset the Test dataset
xTestMeanStd <- getXMeanStd("./inData/test/X_test.txt", 
                            "./inData/features.txt", 
                            "./inData/test/y_test.txt", 
                            "./inData/activity_labels.txt", 
                            "./inData/test/subject_test.txt")

#02. Call function to read and subset the Train dataset
xTrainMeanStd <- getXMeanStd("./inData/train/X_train.txt", 
                             "./inData/features.txt", 
                             "./inData/train/y_train.txt", 
                             "./inData/activity_labels.txt", 
                             "./inData/train/subject_train.txt")

#03. Append rows from the two datasets read above
xMeanStd <- rbind(xTestMeanStd, xTrainMeanStd)
dim(xMeanStd)

#04. Calculates the average of each variable, by activity and subject
library("plyr")
xMeanActSub <- ddply(xMeanStd, .(activityName, subjectId),  numcolwise(mean))
dim(xMeanActSub)

#05. Writes the summarized data to the output file in the outData directory
if(!file.exists("./outData")) { dir.create("./outData") }
write.table(xMeanActSub, file = "./outData/X_mean_activity_subject.txt", append = FALSE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
