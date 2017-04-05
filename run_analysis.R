setwd("~/Personal/Coursera/Class 3 Week 4")

install.packages("plyr")                
library(plyr)

# Step 1
# Merge the training and test sets to create one data set
#

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
x_set <- rbind(x_train, x_test)

# create 'y' data set
y_set <- rbind(y_train, y_test)

# create 'subject' data set
subject_set <- rbind(subject_train, subject_test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
#

features <- read.table("features.txt")

# get only columns with mean() or std() in their names
mean_or_std <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_set <- x_set[, mean_or_std]

# correct the column names
names(x_set) <- features[mean_or_std, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
#

activities <- read.table("activity_labels.txt")

# update values with correct activity names
y_set[, 1] <- activities[y_set[, 1], 2]

# correct column name
names(y_set) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
#

# correct column name
names(subject_set) <- "subject"

# bind all the data in a single data set
all_set <- cbind(x_set, y_set, subject_set)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
#

# runs through the first data set to create a data set of averages
averages_set <- ddply(all_set, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_set, "averages_data.txt", row.name=FALSE)



