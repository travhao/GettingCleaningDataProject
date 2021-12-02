# GettingCleaningDataProject


Week 4 final project for Getting and Cleaning R Data Class.  The data came from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and was unzipped and 
stored in the project folder.

More info about the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Description of what was done

I created one R script called run_analysis.R that does the following: 

-Merges the training and the test sets to create one data set.

-Extracts only the measurements on the mean and standard deviation for each measurement. 

-Uses descriptive activity names to name the activities in the data set

-Appropriately labels the data set with descriptive variable names. 

-From the data set created (in my case I call it "DF"), creates a second, independent tidy data set (called Averages_DF) with the average of each variable for each activity and each subject.


