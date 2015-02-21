# Getting &amp; Cleaning Data Course Project

My interpretation of the assignment was to create a table as shown below with 180 rows (30 subjects times 6 activities): 

|     | subject | activity           | tBodyAcc-mean()-X | ... | fBodyBodyGyroJerkMag.meanFreq() |
|-----|---------|--------------------|-------------------|-----|---------------------------------|
| 1   | 1       | WALKING            | 0.2215982         | ... |             0.17648591          |
| 2   | 1       | WALKING_UPSTAIRS   | 0.2813734         | ... |             0.26480151          |
| 3   | 1       | WALKING_DOWNSTAIRS | 0.2755169         | ... |             0.11069770          |
| 4   | 1       | SITTING            | 0.2635592         | ... |             0.20294938          |
| 5   | 1       | STANDING           | 0.2783343         | ... |             0.02473671          |
| 6   | 1       | LAYING             | 0.2486565         | ... |             0.16376532          |
| 7   | 2       | WALKING            | 0.2501767         | ... |             0.10442295          |
| 8   | 2       | WALKING_UPSTAIRS   | 0.2612543         | ... |             0.21937125          |
| ... | ...     | ...                | ...               | ... | ...          |
| 175 | 30      | WALKING            | 0.2303375         | ... |            -0.07829348          |
| 176 | 30      | WALKING_UPSTAIRS   | 0.2296956         | ... |            -0.17407947          |
| 177 | 30      | WALKING_DOWNSTAIRS | 0.2607616         | ... |             0.06568364          |
| 178 | 30      | SITTING            | 0.2898170         | ... |             0.38799845          |
| 179 | 30      | STANDING           | 0.2845113         | ... |             0.44740104          |
| 180 | 30      | LAYING             | 0.2852744         | ... |            -0.31972324          |

You should see something similar if you run:

>
> data <- read.table("analysis.txt", header = TRUE)
>
> View(data)

# Code Book

I've added two columns to the original 561 (reduced to 79 by only keeping those with "mean" or "std" in their names) found in train/X_train.txt and test/X_test.txt and named in features.txt. 

### subject

These label the 30 volunteers who participated in the experiment.

### activity

These are the 6 activities measured by the smartphone. Instead of using numbers 1 to 6, I mapped them to their corresponding labels found in activity_labels.txt

### mean and std column reduction

To reduce the given 561 measurements to mean and standard deviation measurements as instructed, I extracted those columns whose names included "mean" or "std". This cut the number down to 79.

I did not change the given column names although their values changed to the mean of the readings for each subject as they did each of the 6 measured activities.

### Steps taken

I read the given column names as follows:
 
> colnames <- read.table("UCI HAR Dataset/features.txt")

I then combined the training and test data to recombine all 30 subjects, including the column names:

> X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = colnames[, 2])

> X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = colnames[, 2])

> X <- rbind(X_train, X_test)

I extracted only those column names with "mean" or "std" in them:

> X <- X[, grep("mean|std", colnames[,2], perl=TRUE, value=FALSE)]

I created a new column called activity, replacing the 1 to 6 numbers found in y_train and y_test with their labels:

> activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

> rename <- function(idx) {

>  activity_labels[idx,2] 

> }

> y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity")) 

> y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity")) 

> y <- rbind(y_train, y_test)

> action <- lapply(y, rename)

> X <- cbind(action, X)

I combined and added the subjects named 1 to 30:

> subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject")) 

> subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

> subject <- rbind(subject_train, subject_test)

> X <- cbind(subject, X)

Experienced R programmers will no doubt frown on this, but I used nested for loops to calculate the means for each subject doing a given activity (I unfortunately couldn't figure out how to use functions like ave to achive this by deadline):

> df <- X[c(1:180),]

> row = 1

> for (subject in 1:30) {

>   for (action in c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") ) {

>     df[row,1] = subject

>     df[row,2] = action

>     for (col in (3:ncol(X))) {

>       df[subject, col] = mean(X[which(X$subject == subject & X$activity == act), col])

>     }

>     row = row + 1

>   }

> }

> write.table(df, file ="analysis.txt", row.name=FALSE)


