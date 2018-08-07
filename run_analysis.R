# 1. Merges the training and the test sets to create one data set.

library(dplyr)
library(data.table)

tempTrainValues <- read.table("./UCI HAR Dataset/train/X_train.txt")
tempTrainActivity <- read.table("./UCI HAR Dataset/train/Y_train.txt")
tempTrainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")


tempTestValues <- read.table("./UCI HAR Dataset/test/X_test.txt")
tempTestActivity <- read.table("./UCI HAR Dataset/test/Y_test.txt")
tempTestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

data <- rbind(cbind(tempTrainValues, tempTrainActivity, tempTrainSubject),
                 cbind(tempTestValues, tempTestActivity, tempTestSubject))

features <- read.table("./UCI HAR Dataset/features.txt", as.is = TRUE)

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
setnames(activities, c("V1", "V2"), c("activityId", "activity"))

colnames(data) <- c("subject", features[, 2], "activity")

rm(tempTrainValues, tempTrainActivity, tempTrainSubject, 
   tempTestValues, tempTestActivity, tempTestSubject)


# 2. Extracts only the measurements on the mean and standard deviation
# for each measurement.

goodData <- grepl("subject|activity|mean|std", colnames(data))

data <- data[,goodData]

# 3. Uses descriptive activity names to name the activities in the data set

data$activity <- factor(data$activity, 
                        levels = activities[, 1], labels = activities[, 2])

# 4. Appropriately labels the data set with descriptive variable names.

colnames(data) <- gsub("[\\(\\)-]", "", colnames(data))

colnames(data) <- gsub("^f", "frequencyDomain", colnames(data))
colnames(data) <- gsub("^t", "timeDomain", colnames(data))
colnames(data) <- gsub("Acc", "Accelerometer", colnames(data))
colnames(data) <- gsub("Gyro", "Gyroscope", colnames(data))
colnames(data) <- gsub("Mag", "Magnitude", colnames(data))
colnames(data) <- gsub("Freq", "Frequency", colnames(data))
colnames(data) <- gsub("mean", "Mean", colnames(data))
colnames(data) <- gsub("std", "StandardDeviation", colnames(data))

colnames(data) <- gsub("BodyBody", "Body", colnames(data))

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

dataMeans <- data %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

