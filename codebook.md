# Codebook for the Course Project
## Data Information 
### Data Used: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### A full description of the original data set: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### R Script to create a tidy data set
The attached R script "run_analysis.R" does a variety of steps to create a tidy data set

1. Merges the training and test sets for the measurement values (X_train.txt and X_test.txt), the activity values (y_train.txt and y_test.txt), and the subject numbers (subject_train.txt and subject_test.txt)
  * This results in 3 merged data sets (X, y, subject). Each data set contains 10299 rows, the values and variables are still identical to the original data set.
2. Only keeps the measurement variables in X that contain means or standard deviations. Mean Frequency is *not* included.
  * This results in 66 columns from the original 561 columns
3. Changes the activities in dataset y to activity labels for easier interpretation.
  * The original data set was numbers 1-6, this changes them to:
    * WALKING
    * WALKING UPSTAIRS
    * WALKING DOWNSTAIRS 
    * SITTING
    * STANDING
    * LAYING            
  * It also substituted any "_" to spaces.
4. Merges all 3 cleaned data sets into 1 data set.
  * This results in 10299 rows in 68 columns.
5. Then it takes the merged data set and calculates an average of each mean or standard deviation measurement variable, grouping by subject and activity label. 
  * This results in 180 rows in 68 columns as the number of subjects remain unchanged (1-30) and each subject performed 6 activities (30*6).
6. Writes the tidy data set to the user's working directory.

