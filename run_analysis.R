data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
train_path <- 'UCI HAR Dataset/train'
test_path <- 'UCI HAR Dataset/test'

temp_zip <- tempfile()
download.file(data_url, temp_zip)
#data <- read.table(unz(temp_zip, ))
unlink(temp_zip)