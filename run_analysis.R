## set the work directory to cloned git repo directory
setwd("C:/Users/Fang Liu/Desktop/Fang Learning Video/Coursera-Data Science Specialzation By John Hopkins/3 Getting and cleaning data/getting-and-cleanning-data-course-project")
## load necessary library
library(plyr)
library(data.table)
library(dplyr)
## 1. Explore and read the UCI HAR Dataset
### Read train dataset: x, y, subject, all of txt files have no header names
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
str(x_train)  # 7352 obs. of  561 variables: V1-V561 

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
str(y_train)  # 7352 obs. of  1 variable: $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
unique(y_train$V1)  # 5 4 6 1 3 2

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
str(subject_train)  # 7352 obs. of  1 variable: $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
unique(subject_train$V1) # total 21 subject: 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30 

### Read test dataset: x, y, subject: all of txt files have no header names
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
str(x_test) # 2947 obs. of  561 variables: $V1-$V561

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
str(y_test) # 2947 obs. of  1 variable: $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
unique(y_test$V1) # 5 4 6 1 3 2

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
str(subject_test) # 2947 obs. of  1 variable: $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
unique(subject_test$V1) # total 9 subjects: 2  4  9 10 12 13 18 20 24

### Reading feature dataset: contains the measure names for x_train and x_test dataset 
features <- read.table('./UCI HAR Dataset/features.txt')
str(features)   # 561 obs. of  2 variables: $ V1: int  1 2 3 4 5 6 7 8 9 10 ...; $ V2: Factor w/ 477 levels
unique(features$V1) # measure number 1-561
unique(features$V2) # measure names for 1-561

### Reading activity labels:
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')
str(activityLabels) # 6 obs. of  2 variables:V1 1 2 3...;V2 factor w/6 levels
head(activityLabels)

## 2. Combine the training and the test data: x, y, subject.
x_data <- rbind(x_train, x_test)  # measures, 10299 obs.
y_data <- rbind(y_train, y_test)  # activity_label, 10299 obs. 
subject_data <- rbind(subject_train, subject_test)  #subjectID, 10299 obs.

## 3. Extracts only the measurements on the mean and standard deviation for each measurement.
x_mean_std <- x_data[, grep("-(mean|std)\\(\\)", features[, 2])]
names(x_mean_std) <- features[grep("-(mean|std)\\(\\)", features[, 2]), 2]
str(x_mean_std)   # 10299 obs. of  66 variables
View(x_mean_std)  # view the dataset
dim(x_mean_std)

## 4. Uses descriptive activity names to name the activities in the data set
y_data[, 1] <- activityLabels[y_data[, 1], 2]
names(y_data) <- "activity_label"
View(y_data)  # view the dataset
dim(y_data)   # 10299 obs and 1 variable

## 5. Appropriately labels subject dataset.
names(subject_data) <- "subjectId"
View(subject_data)
dim(subject_data)   # 10299 obs and 1 variable

## 6.Combine x_data, y_data, subject_data into one
data_all <- cbind(x_mean_std, y_data, subject_data)
dim(data_all) # 10299 obs. of  68 variables
View(data_all)

## 7. From combined dataset data_all, create a second independent tidy data set 
## with the average of each measure variable group by subject and activity.
tidydata <- aggregate(. ~subjectId+activity_label, data_all, mean)
dim(tidydata)  #180 obs. of  68 variables
View(tidydata)
### write this tidy dataset to txt file
write.table(tidydata, "tidydata.txt", row.name=FALSE)


