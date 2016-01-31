# the 'run_analysis.R' script does the following:

# 1) Merges the training and the test sets to create one data set.

setwd("C:/Users/ranish.bera/Documents/Online Courses/Data Science Specialization/Part-3-Getting-Cleaning Data/Project-Get-Clean-Data")

make_subject_dataset <- function() {
    subject_test <- read.table('./Data/test/subject_test.txt')
    subject_train <- read.table('./Data/train/subject_train.txt')
    subject_merged <- rbind(subject_train, subject_test)
    names(subject_merged) <- "subject"
    subject_merged
}

make_X_dataset <- function() {
    X_test <- read.table('./Data/test/X_test.txt')
    X_train <- read.table('./Data/train/X_train.txt')
    X_merged  <- rbind(X_train, X_test)
}

make_y_dataset <- function() {
    y_test <- read.table('./Data/test/y_test.txt')
    y_train <- read.table('./Data/train/y_train.txt')
    y_merged  <- rbind(y_train, y_test)
}

subject_dataset <- make_subject_dataset()
X_dataset <- make_X_dataset()
y_dataset <- make_y_dataset()


# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

get_selected_measurements <- function() {
    features <- read.table('./Data/features.txt', header=FALSE, col.names=c('id', 'name'))
    feature_selected_columns <- grep('mean\\(\\)|std\\(\\)', features$name)
    filtered_dataset <- X_dataset[, feature_selected_columns]
    names(filtered_dataset) <- features[features$id %in% feature_selected_columns, 2]
    filtered_dataset
}

X_filtered_dataset <- get_selected_measurements()

# 3) Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table('./Data/activity_labels.txt', header=FALSE, col.names=c('id', 'name'))


# 4) Appropriately labels the data set with descriptive activity names. 

y_dataset[, 1] = activity_labels[y_dataset[, 1], 2]
names(y_dataset) <- "activity"


# 5.1) Creates an intermediate dataset with all required measurements.

whole_dataset <- cbind(subject_dataset, y_dataset, X_filtered_dataset)
write.csv(whole_dataset, "./whole_dataset_with_descriptive_activity_names.csv")


# 5.2) Creates the final, independent tidy data set with the average of each variable for each activity and each subject.

measurements <- whole_dataset[, 3:dim(whole_dataset)[2]]
tidy_dataset <- aggregate(measurements, list(whole_dataset$subject, whole_dataset$activity), mean)
names(tidy_dataset)[1:2] <- c('subject', 'activity')
write.csv(tidy_dataset, "./final_tidy_dataset.csv")
write.table(tidy_dataset, "./final_tidy_dataset.txt")
