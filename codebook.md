# Codebook

# The source data set

The dataset comes from the UCI Machine Learning Repository, specifically: 
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
)

The copy provided to us from the course comes from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# About run_analysis.R

The run_analysis.R script executes the following steps on the original data to obtain the final tidied-up data.

## Step 0: Getting the files together

This step takes the URL given earlier and downloads and extracts the files. 

This step also assigns each data to variables, like so:
2.Assign each data to variables
* features <- features.txt:   
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* activities <- activity_labels.txt:  
List of activities performed when the corresponding measurements were taken and its codes (labels)
* subject_test <- test/subject_test.txt:  
contains test data of 9/30 volunteer test subjects being observed
* x_test <- test/X_test.txt:  
contains recorded features test data
* y_test <- test/y_test.txt:  
contains test data of activities’code labels
* subject_train <- test/subject_train.txt:   
contains train data of 21/30 volunteer subjects being observed
* x_train <- test/X_train.txt:  
contains recorded features train data
* y_train <- test/y_train.txt:  
contains train data of activities’code labels

## Step 1 : Merges the training and the test sets to create one data set.

* X is created by using rbind() on x_train and x_test 
* Y is created by using rbind() y_train and y_test 
* Subject is created by using rbind() on subject_train and subject_test 
* Merged_Data is created by using cbind() on Subject, Y and X 

## Step 2:Extracts only the measurements on the mean and standard deviation for each measurement.

TidyData is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement.

## Step 3: Uses descriptive activity names to name the activities in the data set.

The descriptions are taken from the second column of activities. The code column of the TidyData, which contained numbers, was replaced with corresponding activity taken from activities.

## Step 4: Appropriately labels the data set with descriptive variable names.

* code column in TidyData renamed into activities
* All Acc in column’s name replaced by Accelerometer
* All Gyro in column’s name replaced by Gyroscope
* All BodyBody in column’s name replaced by Body
* All Mag in column’s name replaced by Magnitude
* All start with character f in column’s name replaced by Frequency
* All start with character t in column’s name replaced by Time

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinalData was created by summarizing the TidyData, taking the means of each variable for each activity and each subject, after grouping by subject and activity. The FinalData was then exported via write.table to FinalTinyData.txt