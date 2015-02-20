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

> data <- read.table("analysis.txt", header = TRUE) 
> View(data)

# Code Book

I've added two columns to the original 561 found in train/X_train.txt and test/X_test.txt and named in features.txt. 

### subject

These label the 30 volunteers who participated in the experiment.

### activity

These are the 6 activities measured by the smartphone. Instead of using numbers 1 to 6, I mapped them to their corresponding labels found in activity_labels.txt

### mean and std column reduction

To reduce the given 561 measurements to mean and standard deviation measurements as instructed, I extracted those columns whose names included "mean" or "std". This cut the number down to 79.

I did not change the given column names although their values changed to the mean of the readings for each subject as they did one of the 6 measured activities.


