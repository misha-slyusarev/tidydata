data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

root_path <- 'UCI HAR Dataset'
train_path <- paste(root_path, 'train', sep = '/')
test_path <- paste(root_path, 'test', sep = '/')

features_path <- paste(root_path, 'features.txt', sep = '/')

temp_zip <- tempfile()
download.file(data_url, temp_zip)

features <- read.table(unz(temp_zip, features_path))

View(features)

unlink(temp_zip)