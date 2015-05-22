setwd("C:/Users/Documents/coursera/Getting and Cleaning Data")

# Step 1: Merging test and train sets 
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(xTrain, xTest)

yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
y <- rbind(yTrain, yTest)
 
subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subTrain, subTest)
names(subject)<- "Subject"
mergeA<- cbind(subject, y)

#Step 2: Extracts only means and std deviation measurements, note meanfreq not included
features <- read.table("UCI HAR Dataset/features.txt")
meanIndex <- which(grepl("mean\\(", features$V2))
stdIndex <- which(grepl("std\\(", features$V2))
subFeatures<- rbind(features[meanIndex,], features[stdIndex,])
subX<- X[,subFeatures[,1]]
names(subX)<- subFeatures[,2]
ncol(X)

#Step 3: Merges activity labels to the activity numbers to provide better context of the data
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
yLabels <- merge(mergeA, activityLabels, by="V1")
yLabels <- cbind(yLabels, gsub("_", " ", yLabels$V2))
names(yLabels)<- c("Index", "Subject", "Orig", "Activity")

#Step 4. Merges the subject, the activity, and the appropriate measurements into 
#1 dataset and names the columns accordingly
merge<- cbind(yLabels$Subject, yLabels$Activity, subX)
names(merge)<- c("Subject","Activity", names(subX))

#Step 5: Creates tidy data set by averaging each measurement variable by subject and activity 
library(plyr)
groupColumns<- c("Subject","Activity")
res = ddply(merge, groupColumns, function(x) colMeans(x[,3:ncol(x)]))
write.table(res, file="TidyDataSet.txt",row.name=FALSE)

#Can also write as .csv file for additional functionality
#write.csv(res, file="TidyDataSet.csv")
