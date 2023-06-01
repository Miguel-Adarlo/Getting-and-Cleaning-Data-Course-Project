# Getting-and-Cleaning-Data-Course-Project

This repository contains the requirements for the coursera course Getting and Cleaning Data, which are the following: 

1. A codebook that contains the variables, the data, and any transformations done.
2. The run_analysis.R script that performs the transformations.
3. The final tidy dataset
4. A readme that contains an explanation of the project.

## Dataset:
The dataset comes from the UCI Machine Learning Repository, specifically: 
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
)


## Files:
CodeBook.md details the variables, the data, and any transformations done to the original data.

run_analysis.R contains all the code to tidy the data using these steps as detailed in the course project:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinalTidyData.txt is the output of the final step
