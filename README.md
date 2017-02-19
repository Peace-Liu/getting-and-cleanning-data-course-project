# Getting-and-cleanning-data-course-project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
In this project, the dataset being used is: [Human Activity Recognition Using Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- **run_analysis**.R was created to have all the code to perform the following steps.
- **codebook.md** describes the variables for final tidy data.
- **tidydata.txt** is the final dataset including 180 observation and 68 variables ((subjectID, activity_label, 66 measure variables).
- **README.md** describes the R script process as below.
 
## set the work directory to cloned git repo directory
## load necessary library: 
## 1. Explore and read the UCI HAR Dataset
### Read train txt files: *x, y, subject* using read.table() and exam the contents using str().
- x_train: training dataset contain measures with 7352 obs. of  561 variables which were read from features.txt
- y_train: trainning labels contain 7352 obs. of  1 variable with unique values 5 4 6 1 3 2 which match activity_labels from activity_labels.txt
- subject_train: trainning subjectID list with 7352 obs. of  1 variable with unique subjectID total=21: 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30

### Read test txt files: *x, y, subject* using read.table() and exam the contents using str().
- x_test: testing dataset contain measures with 2947 obs. of  561 variables which were read from features.txt
- y_test: testing labels contain 2947 obs. of  1 variable with unique values 5 4 6 1 3 2 which match activity_labels from activity_labels.txt
- subject_test: testing subjectID list with 2947 obs. of  1 variable with unique subjectID total=9: 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30

### Read feature txt file: using read.table() and exam the contents using str().
- features.txt: contains 561 measure names for x_train and x_test dataset with measure number 1-561 

### Read activity labels txt file: using read.table() and exam the contents using str(). 
- activity_labels.txt: 6 obs. of 2 variables: activity_ID (1:6) and corresponding activity_name matching for y_train and y_test dataset.

## 2. combine training and test with *rbind()*.
- x_data: rbind() to combine x_train and x_test which have all **measures** which names are in features.txt;
- y_data: rbind() to combine y_train and y_test which have all **activity label** ID;
- subject_data: rbind() to combine subject_train and subject_test which have all **subject ID**;

## 3. Extracts only the measurements on the mean and standard deviation on features.txt for x_data.
- Use R regular expression pattern *grep* to identify *mean* or *std* features for meansures in x_data;
- 66 measure variables contain mean and std

## 4. Uses descriptive activity labels to name the activities in y_data matched by ID 1:6
## 5. Appropriately labels subject_data with subjectID.
## 6. Combine x_data, y_data, subject_data into one using *cbind()* ready for creating final tidy dataset
## 7. With the dataset from 6., create a second independent tidy data set with the average of each measure variable group by subject and activity.
- Use *aggregate()* function to create tidy dataset
- This final tidy dataset has 180 observations and 68 variables
- write final tidy dataset to text file saved as **tidydata.txt**

