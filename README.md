# Getting-and-Cleaning-Data

==================================================================
Tidy dataset of Human Activity Recognition Using Smartphones Dataset
==================================================================

The tidy dataset was obtained based on the database retrieved from the UCI Human Activity Recognition Using Smartfones Data Set. 

The script in run_analysis.R does the following: 
1. Download and unzip the original dataset
2. Merges the training and the test sets to create one data set. 
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Finally it outputs the tidy dataset (stored in tidydata_avg) as tidyData_avg.txt
