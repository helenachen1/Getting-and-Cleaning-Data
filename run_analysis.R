
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
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityID")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")


# Test tables:
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityID")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")


# merge dataset
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
data <- rbind(train, test)


##### 3. Extracts only the measurements on the mean and standard deviation for each measurement.
# note: do not include the meanFreq columns
tidydata <- data[,grepl("subject|activityID|mean[^F]|std", colnames(data))]

##### 4. Add descriptive activity names to name the activities in the data set
tidydata <- merge(activity_labels,tidydata,by="activityID")

# remove the excess . and extra Body in some variable names
colnames(tidydata) <- gsub("\\.+",".", colnames(tidydata))
colnames(tidydata) <- gsub("\\.$","", colnames(tidydata))
colnames(tidydata) <- gsub("^f(Body)+","fBody", colnames(tidydata))
 
##### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata_avg <- aggregate(tidydata[, !grepl('subject|activityID|activityType', colnames(tidydata))],  
                          by=tidydata[, c("subject", "activityType")], FUN=mean, na.rm=TRUE)

##### 6. output tidy dataset
write.table(tidydata_avg,file="tidyData_avg.txt",row.names = FALSE)
