==================================================================
Tidy dataset of Human Activity Recognition Using Smartphones Dataset
==================================================================

The tidy dataset was obtained based on the database retrieved from the UCI Human Activity Recognition Using Smartfones Data Set. 

The script in run_analysis.R does the following: 
1. Download and unzip the original dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. Read in features and activity files to get the feature and activity names. Read in the feature, activity and subject files for training and test datasets, give them the right names, and then merge the files to create one data set. 
3. Extract only the measurements on the mean and standard deviation for each measurement from the dataset to create a tidy dataset.
4. Use descriptive activity names to name the activities in the data set with the activity label file. Also, appropriately label the data set with descriptive variable names. 
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Finally output the tidy dataset (stored in tidydata_avg) as tidydata.txt


