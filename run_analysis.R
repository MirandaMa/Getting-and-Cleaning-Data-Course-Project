install.packages("plyr")
library(plyr)
getwd()
setwd("C:/Users/g/Documents/data/UCI HAR Dataset")

######Step 1: Merges the training and the test sets to create one data set
x_train <- read.table("train/X_train.txt") 
y_train <- read.table("train/y_train.txt") 
subject_train <- read.table("train/subject_train.txt") 

x_test <- read.table("test/X_test.txt") 
y_test <- read.table("test/y_test.txt") 
subject_test <- read.table("test/subject_test.txt") 

# combine 'x' data set 
x_data <- rbind(x_train, x_test) 

# combine 'y' data set 
y_data <- rbind(y_train, y_test) 

# combine 'subject' data set 
subject_data <- rbind(subject_train, subject_test) 

##### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt") 

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2]) 

# subset the desired columns 
x_data <- x_data[, mean_and_std_features] 

names(x_data) <- features[mean_and_std_features, 2] 



# Step 3 
# Uses descriptive activity names to name the activities in the data set


activities <- read.table("activity_labels.txt") 
y_data[, 1] <- activities[y_data[, 1], 2] 
names(y_data) <- "activity" 


 # Step 4 
# Appropriately label the data set with descriptive variable names 
 ############################################################################### 


 # correct column name 
 names(subject_data) <- "subject" 


 # bind all the data in a single data set 
 all_data <- cbind(x_data, y_data, subject_data) 


 # Step 5 
# Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject 
 ############################################################################### 
 

# 66 <- 68 columns but last two (activity & subject) 
averages_measurement_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66])) 

write.table(averages_measurement_data, "avg_measurement_data.txt", row.name=FALSE) 





