# download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','raw_data.zip')

library(data.table)
library(dplyr)
library(stringr)

# ###########################################
# Set working directory
# ###########################################

setwd(getwd())

# ##############################################################
# Reading in activity descriptions and features from zipped folder (previously unzipped).
# Cleaning up the features to create names that are more appropriate for train and test datasets
# ##############################################################

activity_description <- read.table('./UCI HAR Dataset/activity_labels.txt',
                                   col.names = c('activity','activity_description'))



features <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/features.txt') %>% 
  mutate(label = str_replace_all(V2,'\\(','')) %>% 
  mutate(label = str_replace_all(label,'\\)','')) %>% 
  mutate(label = str_replace_all(label,'\\-','.')) %>% 
  mutate(label = str_replace_all(label,',','.'))

# ##############################################################
# Create a vector of features to keep (mean and standard deviation)
# ##############################################################

features_mean_std <- grepl('mean|std',features[,'label'])

keep_mean_std <- features[features_mean_std,][['label']]

# ##############################################################
# Reading in text train and test files from zipped folder (previously unzipped)
# Select only variables related to mean and standard deviation
# Label the activities
# Add test subjects
# ##############################################################

train <- read.table('./UCI HAR Dataset/train/X_train.txt',
                    col.names = features[['label']])
train <-train[,keep_mean_std]


train_activity_labels <- read.table('./UCI HAR Dataset/train/y_train.txt',
                                    col.names = c('activity'))
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt',
                            col.names = c('test_subject'))
train['activity'] = train_activity_labels[,'activity']
train['test_subject'] = train_subject[,'test_subject']
train['dataset'] = 'train'



test <- read.table('./UCI HAR Dataset/test/X_test.txt',
                   col.names = features[['label']])
test <-test[,keep_mean_std]

test_activity_labels <- read.table('./UCI HAR Dataset/test/y_test.txt',
                                   col.names = c('activity'))
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt',
                           col.names = c('test_subject'))
test['activity'] = test_activity_labels[,'activity']
test['test_subject'] = test_subject[,'test_subject']
test['dataset'] = 'test'

# ##############################################################
# Join test and train datasets
# ##############################################################

DF <- rbind(train, test) %>% 
  left_join(activity_description, by = 'activity')

rm(test, train)

# ##############################################################
# Create a dataset that averages all mean and standard deviation
# variables by activity, test_subject, dataset and activity_description
# ##############################################################

Averages_DF <- DF %>% 
  group_by(activity, test_subject, dataset, activity_description) %>% 
  summarise(across(.cols = everything(), mean)) %>% 
  ungroup()

# ##############################################################
# Writing out text file of summary variable for my submission
# ##############################################################


write.table(Averages_DF, './UCI HAR Dataset/Averages_DF.txt', row.name=FALSE) 









