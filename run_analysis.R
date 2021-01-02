## Install and require the necessary libraries
#install.packages("readr")
library(readr)
#install.packages("dplyr")
library(dplyr)

## Download the data set and unzip the file:
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data.zip")
unzip(zipfile = "./data.zip")

## Import the features vector and extract names vector
features <- read.table("./UCI HAR Dataset/features.txt")
feature.names <- features$V2

## Import the test and train data sets
feat.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
feat.train <- read.table("./UCI HAR Dataset/train/X_train.txt") 

## Merge the test and train data sets
dat <- rbind(feat.test, feat.train)

## Naming the features 
names(dat) <- feature.names

## Importing the test and train activities
act.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
act.train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Merging the test and train activities
activity <- rbind(act.test, act.train)
activity <- factor(activity$V1)

## Importing labels for activities
act.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
levels(activity) <- act.labels$V2

## Adding labels to data
dat <- cbind(activity, dat)

## Import subjects
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Merging subjects
subject <- rbind(sub_test, sub_train)
subject <- subject$V1
dat <- cbind(subject, dat)

## Selecting measurements on mean and standard deviation
sel <- grepl("\\mean\\()|std\\()", feature.names)
sel <- feature.names[sel]
dat <- dat[,c("subject", "activity", sel)]
names(dat) <- gsub("\\()", "", names(dat))

# install.packages("stringr")
library(stringr)
#install.packages("plyr")
library(plyr)

## Calculate the mean for the each of the records using aggregate function
new_dat <- aggregate(dat[,3:ncol(dat)], list(paste(dat$activity, dat$subject)), mean)

## Splitting the group name to form two new columns
groups <- str_split_fixed(new_dat$Group.1, " ", 2)

## Adding the two columns to the data set
new_dat <- cbind(groups, new_dat)

## Removing the unnecessary column
new_dat <- new_dat[,-3]

## Renaming the columns to reflect their actual purpose
new_dat <- rename(new_dat, c("1" = "activity", "2"="subject"))

## Writing the file into a table
write.table(new_dat, file="./tidy_data.txt", row.names = FALSE)