# 1. Merges the training and the test sets to create one data set.

I start by loading the libraries I'm going to use
Then I read the train and test data in and combine them into one variable - data
I also read in features and activities, then update the activity column names
I update the column names on the data table I just created
Finally I remove the temp variables to clear up space in my workspace

# 2. Extracts only the measurements on the mean and standard deviation
# for each measurement.

Here we sort through the column names for columns of interest, the mean,
standard deviation and our subject and activity column that is a part of this
table now.

# 3. Uses descriptive activity names to name the activities in the data set
Use a factor to map activityIds and activities labels

# 4. Appropriately labels the data set with descriptive variable names.
Removed special symbols
Replaced abbreviations with phrases
Finally fixed typo

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
Here I group by activity and subject then I summarize using the average