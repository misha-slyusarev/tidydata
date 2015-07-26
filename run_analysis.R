
data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20dataset.zip'

root_path <- 'UCI HAR Dataset'
train_data_path <- paste(root_path, 'train', sep = '/')
test_data_path <- paste(root_path, 'test', sep = '/')

if( ! file.exists(root_path) ){
  temp_zip <- tempfile()
  download.file(data_url, temp_zip)
  unzip(temp_zip)
  unlink(temp_zip)
}

# Step 1. Merges the training and the test sets to create one data set

data_train_raw      <- read.table(paste(train_data_path, 'X_train.txt', sep = '/'))
data_train_labels   <- read.table(paste(train_data_path, 'y_train.txt', sep = '/'), col.names = "Label")
data_train_subjects <- read.table(paste(train_data_path, 'subject_train.txt', sep = '/'), col.names = "Subject")

data_test_raw       <- read.table(paste(test_data_path, 'X_test.txt', sep = '/'))
data_test_labels    <- read.table(paste(test_data_path, 'y_test.txt', sep = '/'), col.names = "Label")
data_test_subjects  <- read.table(paste(test_data_path, 'subject_test.txt', sep = '/'), col.names = "Subject")

features <- read.table(paste(root_path, 'features.txt', sep = '/'),
                       row.names = 1, col.names = c("ID", "Name"))

colnames(data_train_raw) <- features$Name
colnames(data_test_raw) <- features$Name

data_train <- cbind(data_train_subjects, data_train_labels, data_train_raw)
data_test <- cbind(data_test_subjects, data_test_labels, data_test_raw)

data <- rbind(data_train, data_test)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement

measurments <- grep('mean\\(|std\\(', names(data), value = TRUE)
data <- data[, c('Subject', 'Label', measurments)]

# Step 3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table(paste(root_path, 'activity_labels.txt', sep='/'),
                              col.names = c('Label', 'Name'))

factor_activities <- as.factor(data$Label)
levels(factor_activities) <- activity_labels$Name
data$Label <- factor_activities

# Step 4. Appropriately labels the data set with descriptive variable names

names(data)<-gsub("^t", "Time", names(data))
names(data)<-gsub("^f", "Frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

# Step 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

output_data <- aggregate(. ~Subject + Label, data, mean)
output_data <- output_data[order(output_data$Subject, output_data$Label),]
write.table(output_data, file = "tidydata.txt", row.name=FALSE)
