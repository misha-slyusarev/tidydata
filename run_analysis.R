
data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

root_path <- 'UCI HAR Dataset'
train_data_path <- paste(root_path, 'train', sep = '/')
test_data_path <- paste(root_path, 'test', sep = '/')

if( ! file.exists(root_path) ){
  temp_zip <- tempfile()
  download.file(data_url, temp_zip)
  unzip(temp_zip)
  unlink(temp_zip)
}

feature_names <- read.table(paste(root_path, 'features.txt', sep = '/'),
                       row.names = 1, col.names = c("ID", "Name"))

data_train <- read.table(paste(train_data_path, 'X_train.txt', sep = '/'))
data_train_labels <- read.table(paste(train_data_path, 'y_train.txt', sep = '/'))

data_test <- read.table(paste(test_data_path, 'X_test.txt', sep = '/'))
data_test_labels <- read.table(paste(test_data_path, 'y_test.txt', sep = '/'))

colnames(data_train) <- feature_names$Name
colnames(data_test) <- feature_names$Name

#print( dim(data_train) )
#print( dim(data_test) )

#activity_labels <- read.table(paste(root_path, 'activity_labels.txt', sep='/'),
#                              col.names = c('Label', 'Name'))
#View(activity_labels)