#run_analysis.r - by Miguel Adarlo

library(dplyr)

##Step 0: Getting the files together

filename <- "Getting-and-Cleaning-Data-Project.zip"

# First, we check if the file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Then, we check if the folder exists beforehand
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##Step 1 : Merges the training and the test sets to create one data set.
#As to how we know what to fuse: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#look at how the data looks like
str(Merged_Data)

##Step 2:Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
str(TidyData)

##Step 3: Uses descriptive activity names to name the activities in the data set.
#Descriptions are taken from the second column of activities.
TidyData$code <- activities[TidyData$code, 2]
str(TidyData)

##Step 4: Appropriately labels the data set with descriptive variable names.
#Renaming things such as from Code to Activity, and using longer names for everything else
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#This data has the changes done before in place.
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalTinyData.txt", row.name=FALSE)

#Checking the data at the end
str(FinalData)
View(FinalData)