## Getting-and-cleanning-data-course-project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
In this project, the dataset being used is: [Human Activity Recognition Using Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
**run_analysis**.R was created to have all the code to perform the following steps and upload into github.
**codebook.md** describes the variables and other meta data.
 
### Set up the work directory
### Read the x training/test data file using read.table() command and exam the contents.
- x_train.txt: Training set.
- x_test.txt: Test set.
#### combine x training and test with *rbind* to create **x_data**.

### Read the y training/test data file and exam the contents.
- y_train.txt: Training labels.
- y_test.txt': Test labels.
#### combine y training and test with *rbind* to create **y_data**.

### Read the subject training/test data file and exam the contents.
- subject_train.txt: Each row identifies the subject who performed the activity.
- subject_test.txt': Each row identifies the subject who performed the activity.
#### combine subject training and test with *rbind* to create **subject_data**.

### Read the feature and activity labels
- features.txt: List of all features for x datasets.
- activity_labels.txt: Links the class labels with their activity name linked to y datasets.

### Extracts the measurements on the mean and standard deviation for each measurement.

#### Use R regular expression pattern *grep* to identify if *mean* or *sd* is in the features,
then apply to **x_data** to only keep such measures and give colnames ;
#### Match activity labels by activityId for **y_data**
#### Label meaningful colnames as *subjectId* for **subject_data** 

### Combine **x-data**, **y_data**, and **subject_data** with R *cbind* command to 
create **data_all**

### With combined dataset to create a second tidy dataset with the average of 
each variable for each activity and each subject, then write this dataset as 
text file **data2_avg.txt** which was uploaded in github.
