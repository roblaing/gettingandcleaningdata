# 1 Merges the training and the test sets to create one data set.
colnames <- read.table("UCI HAR Dataset/features.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = colnames[, 2])
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = colnames[, 2])
X <- rbind(X_train, X_test)

# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
X <- X[, grep("mean|std", colnames[,2], perl=TRUE, value=FALSE)]

# 3 Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

rename <- function(idx) {
  activity_labels[idx,2] 
}

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity")) 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity")) 
y <- rbind(y_train, y_test)
action <- lapply(y, rename)
X <- cbind(action, X)

# 4 Appropriately labels the data set with descriptive variable names. 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject")) 
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
subject <- rbind(subject_train, subject_test)
X <- cbind(subject, X)

# 5 From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

df <- X[c(1:180),]

row = 1
for (subject in 1:30) {
  for (action in c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") ) {
    df[row,1] = subject
    df[row,2] = action
    for (col in (3:ncol(X))) {
      df[subject, col] = mean(X[which(X$subject == subject & X$activity == act), col])
    }
    row = row + 1
  }
}

write.table(df, file ="analysis.txt", row.name=FALSE)


