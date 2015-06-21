
# path to all the files

file1 <- "./test/X_test.txt"
file2 <- "./train/X_train.txt"
header_file <- "./features.txt"
activity_file1 <- "./test/y_test.txt"
activity_file2 <- "./train/y_train.txt"
activity_file <- "./activity_labels.txt"
subject_file1 <- "./test/subject_test.txt"
subject_file2 <- "./train/subject_train.txt"

# Read the header files
x <- read.table(header_file)

# Transposing the header data into columns
df <- data.frame()
df <- t(x[,2])
colnames(dataset1) <- df
colnames(dataset2) <- df
n1 <- colnames(dataset1)
n2 <- colnames(dataset2)



dataset1 <- read.table(file1, header = FALSE, col.names = n1,  sep="")
dataset2 <- read.table(file2, header = FALSE, col.names = n2,  sep="")

# Reading the activity data from test and training data sets

y1 <- read.table(activity_file1, header = FALSE)
y2 <- read.table(activity_file2, header = FALSE)

# Reading the subject data from test and training data sets

z1 <- read.table(subject_file1, header = FALSE)
z2 <- read.table(subject_file2, header = FALSE)


# creating activity data frame
dg <- data.frame()
dg <- rbind(y1, y2)
colnames(dg) <- c("activityid")

# creating subject data frame
dh <- data.frame()
dh <- rbind(z1, z2)
colnames(dh) <- c("subject")

#creating activity file data frame
da <- data.frame()
da <- read.table(activity_file, header = FALSE)
colnames(da) <- c("activityid", "activitytype")


# merging activity, subject and data for test and training data sets

m_dataset <- merge(dataset1, dataset2, all = TRUE)
f1_dataset <- cbind(dg, dh, m_dataset)

colNames <- colnames(f1_dataset)

#Finding patterns for the selective columns

LogicalVector = (grepl("activity..",colNames)|grepl("sub..",colNames)|grepl("mean..",colNames)|grepl("-mean..",colNames)|grepl("Mean..",colNames)|grepl("-std..",colNames)|grepl("-std()..",colNames)|grepl("std..",colNames))

# selecting only columns which match the pattern

f2_dataset <- f1_dataset[LogicalVector == TRUE]

# Adding another column activitytype to the dataset
f3_dataset <- merge(f2_dataset, da, by='activityid', all.x=TRUE)

colNames <- colnames(f3_dataset)


  colNames <- gsub("tBodyAcc.","BodyAcc", colNames)
  colNames <- gsub("tBody","Body", colNames)
  colNames <- gsub("fBody","Body", colNames)
  colNames <- gsub("tBodyAccJerk.","BodyAccJerk", colNames)
  colNames <- gsub("BodyBody","Body", colNames)
  colNames <- gsub(".meanFreq","MeanFrequency", colNames)
  colNames <- gsub(".mean...","Mean", colNames)
  colNames <- gsub("tGravity","Gravity", colNames)
  colNames <- gsub("angle","Angle", colNames)
  colNames <- gsub(".std","StdDev", colNames)
  colNames <- gsub("Mean...","Mean", colNames)
  colNames <- gsub("StdDev...","StdDev", colNames)


colnames(f3_dataset) <- colNames
f3_datasetwoacttype <- f3_dataset[,names(f3_dataset)!= "activitytype"]



# Calculate mean for the data
tidydatamean <- aggregate(f3_datasetwoacttype[, names(f3_datasetwoacttype)!= c('activityid', 'subject')],
              by=list(activityid = f3_datasetwoacttype$activityid, subject=f3_datasetwoacttype$subject), FUN=mean)


tidydata <- merge(tidydatamean, da, by ='activityid', all.x =TRUE)

write.table(tidydata, "./tidydata.txt", row.names =FALSE, sep=",")
