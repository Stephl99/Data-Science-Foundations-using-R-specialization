# Run Analysis

# Preparing the packages
library(dplyr)

# Reading the data

variables <- read.table("./data/UCIDataset/features.txt", col.names = c("n", "nombre"))
actividades <- read.table("./data/UCIDataset/activity_labels.txt",
                          col.names = c("n", "actividad"))
subject_test <- read.table("./data/UCIDataset/test/subject_test.txt", 
                           col.names = "subject")
subject_train <- read.table("./data/UCIDataset/train/subject_train.txt", 
                            col.names = "subject")
X_train <- read.table("./data/UCIDataset/train/X_train.txt", 
                      col.names = variables$nombre)
X_test <- read.table("./data/UCIDataset/test/X_test.txt", 
                     col.names = variables$nombre) 
y_train <-  read.table("./data/UCIDataset/train/y_train.txt", 
                       col.names = "codigo")
y_test <-  read.table("./data/UCIDataset/test/y_test.txt", 
                      col.names = "codigo")

# 1. Merges the training and the test sets to create one data set.

X <- rbind(X_train, X_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

data <- cbind(subject, Y, X)

# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement.

tidy <- data %>% select(subject, codigo, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set.

tidy$codigo <- actividades[data$codigo, 2]

# 4. Appropriately labels the data set with descriptive variable names.

names(tidy)[1] <- "Subject"
names(tidy)[2] <- "Activity"
names(tidy) <- gsub("mean", "Mean", names(tidy))
names(tidy) <- gsub("std", "Std", names(tidy))
names(tidy) <- gsub("gravity", "Gravity", names(tidy))
names(tidy) <- gsub("BodyBody", "Body", names(tidy))
names(tidy) <- gsub("^t", "Time", names(tidy))
names(tidy) <- gsub("^f", "Frecuency", names(tidy))
names(tidy) <- gsub("Acc", "Accelerometer", names(tidy))
names(tidy) <- gsub("Mag", "Magnitude", names(tidy))
names(tidy) <- gsub("[[:punct:]]", "", names(tidy))
names(tidy) <- gsub("^angle", "Angle", names(tidy))
names(tidy) <- gsub("^Anglet", "AngleTime", names(tidy))
names(tidy)<- gsub("Gyro", "Gyroscope", names(tidy))

head(tidy)

# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.

average_table <- tidy %>% group_by(Subject, Activity) %>% summarise_all(list(mean))

write.table(average_table, file = "./data/FinalData.txt",row.name=FALSE)
?write.table

names(data)[3]
