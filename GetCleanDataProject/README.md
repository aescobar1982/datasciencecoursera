## Creating tidy data set for HAR (Human Activity Recognition) data

The original data contain measurements acceleration and angular velocity from acceleromter (Acc) and gyroscope (Gyro) measurements.

Measuresments were mapped onto either a time (t) or frequency (f) domain to create activity windows.

Acceleration data is further broken down into body (Body) and gravity (Gravity) acceleration.

Linear acceleration and angular velocity also used to calculate jerk (Jerk) signals and Euclidean norm (Mag)

The contained script run_analysis.R performs the following steps to collect, clean, and transform data from the Human Activity Recognition dataset from the UCI Machine Learning data repository.


# Collect and merge data

1) Download original data files from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2) Load test and train data sets (X_test.txt and X_train.txt) with feature names (features.txt) as column names
3) Apply subject and activity numbers to each record (subject_test.txt, subject_train.txt, y_test.txt,y_train.txt)
4) Merge test and train data sets into one dataset

# Extract measures of interest

5) Identify fields for means (.mean) and standard deviations (.std)
6) Extract only mean and standard deviation fields (along with subject and activity ID numbers) from full dataset

# Apply labels to activity ID numbers

7) Merge data set with activity names (activity_labels.txt) on activitynum

# Take average of each variable for each subject and each activity

8) Calculates mean of each variable for each level of subject number/activity name
9) Names each column variablename_mean

# Outputs final tidy data set of means to harDataMeans.csv

See CodeBook for description of final variables in output