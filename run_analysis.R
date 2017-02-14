setwd("C:/Users/Fang Liu/Desktop/Fang Learning Video/Coursera-Data Science Specialzation By John Hopkins/3 Getting and cleaning data/Course Project")
## 1. Merges the training and the test sets to create one data set.

### reading training tables
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
str(x_train)  # 7352 obs. of  561 variables: V1-V561
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
str(y_train)  # 7352 obs. of  1 variable: V1  5 5 5 5 5 5...
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
str(subject_train)  # 7352 obs. of  1 variable V1 1 1 1...

### Reading testing tables:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
str(x_test) # 2947 obs. of  561 variables: V1-V561
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
str(y_test) # 2947 obs. of  1 variable:V1 5 5 5...
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
str(subject_test) # 2947 obs. of  1 variable:V1 2 2 2...

### Reading feature vector:
features <- read.table('./UCI HAR Dataset/features.txt')
str(features)   # 561 obs. of  2 variables:V1 1,2,3...; V2 factor w/47 levels

### Reading activity labels:
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')
str(activityLabels) # 6 obs. of  2 variables:V1 1 2 3...;V2 factor w/6 levels

### combine X dataset
x_data <- rbind(x_train, x_test)
### combine y dataset
y_data <- rbind(y_train, y_test)
### combine subject dataset
subject_data <- rbind(subject_train, subject_test)
### merge all together 
data1 <- cbind(subject_data, y_data, x_data)
colnames(data1) <- c("subjectId", "activityId", features[,2])
colnames(activityLabels) <- c('activityId','activityType')
str(data1)  # 10299 obs. of  563 variables:
colNames <- colnames(data1)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
sum(mean_and_std) ##15219
### get the subset of dataset
data_mean_sd <- data1[ , mean_and_std==TRUE]
str(data_mean_sd) # 10299 obs. of  9 variables

########
x_data<-x_data[,mean_and_std==TRUE] # 10299 obs. of  9 variables
names(x_data) <- features[mean_and_std, 2]
#######

## 3. Uses descriptive activity names to name the activities in the data set
#data1_actvnames <- merge(data1, activityLabels, by='activityId', all.x = TRUE)
# Error in fix.by(by.x, x) : 'by' must specify a uniquely valid column
data1[,2] <- activityLabels[data1[,2], 2]
unique(data1$activityID)  
#Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS

### rename col name 'activityId' to 'activityname'
colnames(data1)[2] <- "activityname"
str(data1)

######
y_data[, 1] <- activityLabels[y_data[, 1], 2]
names(y_data) <- "activityname"
######

## 4. Appropriately labels the data set with descriptive variable names.
### already did in 1.

names(subject_data) <- "subjectId"

####### bind all x_data, y_data, subject_data
data_all <- cbind(x_data, y_data, subject_data)
str(data_all) # 10299 obs. of  11 variables
######

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
library(dplyr)
data2_avg <- aggregate(. ~subjectId+activityname, data_all, mean)
str(data2_avg)  #180 obs. of  11 variables
head(data2_avg)
names(data2_avg)
## write this tidy dataset to txt file
write.table(data2_avg, "data2_avg.txt", row.name=FALSE)


