# run_analysis.R
# Getting and Cleaning Data
# Coursera
# John Hopkins University
# Anton Kuiper
# Anton.kuiper@gmail.com
# date: October 2014
##################################################
#
# Getting and Cleaning Data Course Project
#
##################################################
# 
#Project
#You should create one R script called run_analysis.R that does the following. 
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names. 
#5 From the data set in step 4, creates a second, independent tidy 
#    data set with the average of each variable for each activity and each subject.
#
# download dataset
# fIrst analyze the dataset
# write the file url and file destination to an object
#setwd("../Coursera/003 Getting and Cleaning Data/Project")
#file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip '
#temp <- tempfile()

# download from the URL
#download.file(file.url, temp )
#dateDownloaded <- date()
#dateDownloaded

# uciset <- combined set
#  UNZIP the dataset manually in the "root"
#unlink(temp)
#  The training dataset exist of three data files
# X_train, Y_Train, subject_train.  these are combined into the dataset training.
# add now as kolom 562 the Y_train
# add now as kolom 563 the subject_train
train_set = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train_set[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train_set[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

#same for the test_set
# combine X_test, Y_test and subject_test.
# add now as kolom 562 the Y_train
# add now as kolom 563 the subject_train
test_set = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_set[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_set[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# the activityLabels source
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Read features and make the feature names better suited for R with some substitutions
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# combine train_set and Test_Set.
All_data_set = rbind(train_set, test_set)

# Get only the data on mean and std. dev.
MeanStdCol <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[MeanStdCol,]
# Now add the last two columns (subject and activity)
MeanStdCol <- c(MeanStdCol, 562, 563)
# And remove the unwanted columns from allData
All_data_set <- All_data_set[,MeanStdCol]
## END OF STEP 2!

colnames(All_data_set) <- c(features$V2, "Activity", "Subject")
## END OF STEP 4 - well formatted labels!

## 
colnames(All_data_set) <- tolower(colnames(All_data_set))
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  All_data_set$activity <- gsub(currentActivity, currentActivityLabel, All_data_set$activity)
  currentActivity <- currentActivity + 1
}

All_data_set$activity <- as.factor(All_data_set$activity)
All_data_set$subject <- as.factor(All_data_set$subject)

tidy = aggregate(All_data_set, by=list(activity = All_data_set$activity, subject=All_data_set$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "UCI_tidy_data_set.txt", sep="\t")