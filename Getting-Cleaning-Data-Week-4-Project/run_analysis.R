# 0. Preliminary: setup environment and download files if not already exist
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 0. Preliminary steps 
library(dplyr)  
library(data.table)
library(tidyselect)
library(reshape2)

#setwd("/Volumes/Samsung_T5/Lessons/Coursera-DataScience/DataCleaning/week4/submission")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datapath <- paste0(getwd(), "/UCI HAR Dataset")

if (!file.exists("dataset.zip")){
  download.file(url,destfile = "dataset.zip", method = "curl")
  dateDownloaded <- date()
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip("dataset.zip")
}

#load txt data into data frames with columns labelled
features <- read.table("./UCI HAR Dataset/features.txt"
                            , col.names = c("featureId", "featureName"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt"
                         , col.names = c("activityId", "activityName"))
selectedVariableNames <- features[grep("mean\\(\\)|std\\(\\)",features[,"featureName"]),]
selectedMeasures <- as.character(selectedVariableNames[,2])
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt"
                           , col.names = "subjectId")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt"
                          , col.names = "subjectId")

# load data for selected measures containing "mean" and "std" in variable names
xTrain <- data.table(read.table("./UCI HAR Dataset/train/x_train.txt")[selectedVariableNames[,1]])
xTest <- data.table(read.table("./UCI HAR Dataset/test/x_test.txt")[selectedVariableNames[,1]])

# load activity data for train and test data sets
yTrain <- data.table(read.table("./UCI HAR Dataset/train/y_train.txt"))
yTest <- data.table(read.table("./UCI HAR Dataset/test/y_test.txt"))

#label column names of train and test data before merging
colnames(xTrain) <- selectedMeasures
colnames(xTest) <- selectedMeasures
colnames(yTrain) <- "activityId"
colnames(yTest) <- "activityId"

#merge activity to its names in both train and test data
yTrain <- merge(yTrain, activities
                , by="activityId"
                , all.x = TRUE)
yTest <- merge(yTest, activities
                , by="activityId"
                , all.x = TRUE)

#combine all train columns into a dataset
trainData <- cbind(subjectTrain,yTrain[,2],xTrain)
colnames(trainData)[2] <- "activityName"
#combine all test columns into a dataset
testData <- cbind(subjectTest,yTest[,2],xTest)
colnames(testData)[2] <- "activityName"
#merge both train and test data
mergedData <- rbind(trainData,testData)

#calculate average for each activity and subject
combined.long <- reshape2::melt(data = mergedData, id = c("subjectId", "activityName"))
combined.wide <- reshape2::dcast(combined.long, subjectId + activityName ~ variable, mean)

#save combined.wide as txt file
data.table::fwrite(x = combined.wide, file = "tidydata.txt", quote = FALSE)
