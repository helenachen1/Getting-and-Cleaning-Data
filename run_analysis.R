
library(tidyverse)
library(dplyr)

##### 1. download and unzip data
zipfile <- "Data.zip"
zipfileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "

if (!file.exists(zipfile)){
    download.file(zipfileURL, zipfile, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipfile) 
}

##### 2. read in data and merge the train and the test sets to create one data set.
# Feature and activity label:
features <- read.table('UCI HAR Dataset/features.txt')
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt',col.names = c("activityID","activityType"))

# Train tables:
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) <- features[,2]
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")


# Test tables:
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[,2]
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")


# merge dataset
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
data <- rbind(train, test)


##### 3. Extracts only the measurements on the mean and standard deviation for each measurement.
# note: do not include the meanFreq columns
tidydata <- data[,grepl("subject|activity|mean\\(\\)|std\\(\\)", colnames(data))]

##### 4. Add descriptive activity names to name the activities in the data set
tidydata$activity <- activity_labels[tidydata$activity,2]

# change the colnames to be more descriptive
colnames(tidydata) <- gsub("^t","Time", colnames(tidydata))
colnames(tidydata) <- gsub("Acc","Acceleration", colnames(tidydata))
colnames(tidydata) <- gsub("Gyro","Gyroscope", colnames(tidydata))
colnames(tidydata) <- gsub("Mag","Magnitude", colnames(tidydata))                     
colnames(tidydata) <- gsub("^f(Body)+","FrequencyBody", colnames(tidydata))
colnames(tidydata) <- gsub("mean\\(\\)","Mean", colnames(tidydata))
colnames(tidydata) <- gsub("std\\(\\)","StandardDeviation", colnames(tidydata))
colnames(tidydata) <- gsub("-","", colnames(tidydata))
 
##### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata_avg <- aggregate(. ~ subject + activity, tidydata, FUN=mean, na.rm=TRUE)

##### 6. output tidy dataset
write.table(tidydata_avg,file="tidydata.txt",row.names = FALSE)
