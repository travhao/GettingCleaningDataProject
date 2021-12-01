library(data.table)
library(dplyr)
library(stringr)


activity_description <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/activity_labels.txt',
                                   col.names = c('activity','activity_description'))


features <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/features.txt')
features2 <-features %>% 
  mutate(label = str_replace_all(V2,'\\(','')) %>% 
  mutate(label = str_replace_all(label,'\\)','')) %>% 
  mutate(label = str_replace_all(label,'\\-','.')) %>% 
  mutate(label = str_replace_all(label,',','.'))


# download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','raw_data.zip')
train <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/train/X_train.txt',
                    col.names = features2[['label']])
train_activity_labels <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/train/y_train.txt',
                                    col.names = c('activity'))
train_subject <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/train/subject_train.txt',
                            col.names = c('test_subject'))
train['activity'] = train_activity_labels[,'activity']
train['test_subject'] = train_subject[,'test_subject']
train['dataset'] = 'train'



test <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/test/X_test.txt',
                   col.names = features2[['label']])
test_activity_labels <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/test/y_test.txt',
                                   col.names = c('activity'))
test_subject <- read.table('C:/Users/Helm/Desktop/GettingCleaningDataProject/UCI HAR Dataset/test/subject_test.txt',
                           col.names = c('test_subject'))
test['activity'] = test_activity_labels[,'activity']
test['test_subject'] = test_subject[,'test_subject']
test['dataset'] = 'test'

DF <- rbind(train, test) %>% 
  left_join(activity_description, by = 'activity')







