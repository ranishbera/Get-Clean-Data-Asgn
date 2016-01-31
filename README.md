Getting and Cleaning Data - Final Assignment
# run_analysis.R

This R script performs the following steps, as per the project assignment instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## how to download the original data

This script assumes that you have already downloaded and unzipped the original Samsung data in a folder called _Data_. If this is not the case, you must first run the script called `download_data.R`. In your R enviroment, load it:
