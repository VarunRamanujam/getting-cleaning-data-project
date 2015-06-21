Step 1

Get all the files in the working directory.

file1 <- "./test/X_test.txt"
file2 <- "./train/X_train.txt"
header_file <- "./features.txt"
activity_file1 <- "./test/y_test.txt"
activity_file2 <- "./train/y_train.txt"
activity_file <- "./activity_labels.txt"
subject_file1 <- "./test/subject_test.txt"
subject_file2 <- "./train/subject_train.txt"


Step 2

Read the data in all the files


Step 3

Create column names for all the files 

Step 4

Merge main data sets with the activity and subject files. Get only the columns which has mean and std dev in their names.

Step 5

Substitute the column names to some realistic names

Step 6

Calculate the means for all the subjects, with their activity names


Step 7

Create a tidy data set for review.
