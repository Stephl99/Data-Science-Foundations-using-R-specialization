# Getting and Cleaning Data Course Project Code Book

The initial step was read the data files into R, then i did the following steps:

1. Merges the training and the test sets to create one data set. I created the __tidy__ data set with the `rbind()` function.

2. Extracts only the measurements on the mean and standard deviation for each measurement. I did this with the functions `select()` and `contains()` from the package `dplyr`.  

3. Uses descriptive activity names to name the activities in the data set. I changed the codes in __tidy__ with the activities in the file __activity_labels.txt__.  

4. Appropriately labels the data set with descriptive variable names. I did this with the `gsub()` function and some regular expressions.  

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. For this step, first i used the functions `group_by()` and `summarize_all()` (variation of the `summarize()` function) from the package `dplyr`.

## Initial data 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

## Feature transformation

* A  factor variable called `Activity` with the following levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

* The initial variables with some modifications in the names. Some variables are specified in this way:

  * Subject.
  * Activity.
  * TimeBody: Accelerometer-Gyroscope Jerk-Mean-Std X-Y-Z.
  * TimeGravity: Accelerometer Jerk-Mean-Std X-Y-Z.
  * FrecuencyBody: Accelerometer-Gyroscope Jerk-Magnitude-Mean-Std X-Y-Z.
  * AngleTimeBodyAccelerometerMeanGravity.
  * AngleTimeBodyAccelerometerMeanGravity.

I used the `write.table()` function to save the file __tidy_dataset.txt__.
