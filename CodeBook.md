# Code Book

I've added two columns to the original 561 found in train/X_train.txt and test/X_test.txt and named in features.txt. 

### subject

These label the 30 volunteers who participated in the experiment.

### activity

These are the 6 activities measured by the smartphone. Instead of using numbers 1 to 6, I mapped them to their corresponding labels found in activity_labels.txt

### mean and std column reduction

To reduce the given 561 measurements to mean and standard deviation measurements as instructed, I extracted those columns whose names included "mean" or "std". This cut the number down to 79.

I did not change the given column names although their values changed to the mean of the readings for each subject as they did one of the 6 measured activities.


