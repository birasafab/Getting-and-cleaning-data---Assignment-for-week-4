### this is my work regarding the assignment the week 4 ####
# checking the current directory
getwd()
# changing the current directory to the desired one
setwd("C:/Users/user/OneDrive/Learning on Coursera/Coursera online R learning/Course 3_Getting Data and cleaning/assignment")
# creating a data file after checking if there'sn't
if(!file.exists("./data")){dir.create("./data")}
# creating the link to data set for download
link1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# downloading the data file in the provided link
download.file(link1,"./data/dataset.zip")
# unzipping the downloaded data file
unzip("./data/dataset.zip",exdir = "./data")
# indicating the folder containing the desired data
setwd ("C:/Users/user/OneDrive/Learning on Coursera/Coursera online R learning/Course 3_Getting Data and cleaning/assignment/data/UCI HAR Dataset")

## loading data
# train data
train_subject<-read.table("./train/subject_train.txt")
train_x <- read.table("./train/X_train.txt")
train_y<-read.table("./train/y_train.txt")
# test data
test_subject<- read.table("./test/subject_test.txt")
test_x <- read.table("./test/x_test.txt")
test_y <- read.table("./test/y_test.txt")

# combining data
trainData<- cbind(train_subject,train_y,train_x)
testData <- cbind(test_subject,test_y,test_x)

# Merge data
mergeData = rbind(trainData,testData)


## Get the feature of the data
feature<-read.table("./features.txt", stringsAsFactors = FALSE)[,2]
## add feature into the data
featureIndex<- grep(("mean\\(\\)|std\\(\\)"),feature)

DATA<-mergeData[,c(1,2,featureIndex)]

## Providing column names in the just created data set "DATA"
colnames(DATA)<-c("subject","activity",feature[featureIndex])

## Uses descriptive activity names to name the activities the data set
## get activity name
ActivityName<- read.table("./activity_labels.txt")
ActivityName
head(DATA$activity)
unique(DATA$activity)

## appropriately lables the data set with descriptive variable names.
names(DATA)[1:10]
names(DATA)<-gsub("\\()","",names(DATA))
names(DATA)<-gsub("^t","time",names(DATA))
names(DATA)<-gsub("-mean","Mean",names(DATA))
names(DATA)<-gsub("^f","frequence",names(DATA))
names(DATA)<-gsub("-std","Std",names(DATA))
names(DATA)<-gsub("BodyBody","Body", names(DAT))
names(DATA)<-gsub("Gyro","Gyroscope",names(DATA))

## Creating tidyData set by finding average of each variable for each activity and each subject
library(plyr)
tidyData<-aggregate(. ~subject + activity, DATA, mean)

## ordering the tidyData set by subject and activity
tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]

## writting/creating a text (.txt) file of the tidy data set just created above 
write.table(tidyData,"./tidyData.txt")
