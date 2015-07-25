
data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

if( ! file.exists(temp_zip) ){
  temp_zip <- tempfile()
  download.file(data_url, temp_zip)
}

root_path <- 'UCI HAR Dataset'
train_data_path <- paste(root_path, 'train/X_train.txt', sep = '/')
test_data_path <- paste(root_path, 'test/X_test.txt', sep = '/')

data_train <- read.table(unz(temp_zip, train_data_path))
data_test <- read.table(unz(temp_zip, test_data_path))

print( dim(data_train) )
print( dim(data_test) )

unlink(temp_zip)