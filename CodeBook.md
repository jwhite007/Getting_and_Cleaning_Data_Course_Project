#Code Book

##The Original Data

Downloaded on Dec 08, 2014  
The original data is in the samsung_data.zip file contained in the repository.   

[Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
www.smartlab.ws

Signals were obtained from the accelerometers and gyroscopes of smart phones (Samsung Galaxy S II) worn by 30 subjects between the ages of 19 and 48 doing various activities in replicate. These subjects were randomly segregated into a training set (70% of the subjects) and a test set (30% of the subjects).

The activities in the original data are coded as numerics, and the numerics assigned to each activity are noted below:

- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

These signals were pre-processed and were then sampled in fixed-width sliding windows of 2.56 secs and 50% overlap (128 readings). Detailed information can be found in README.txt included with the original data.

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ." 't' denotes time domain signals. The acceleration signals were separated into body and gravity acceleration signals. Jerk signals were derived from this data. In addition, a Fast Fourier Transform (FFT) was applied to some of these signals and are labeled with an 'f' to denote frequency domain signals. Each feature has been normalized to values bounded by [-1,1] and are therefore unitless. Detailed information can be found in features_info.txt included with the original data.

The features obtained are denoted as such:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The final dataset is comprised of variables estimated from the above features and are:

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors used in the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

##Explanation of the resulting dataset produced by sourcing run_analysis.R
Details on how the original data was manipulated to obtain the resulting dataset can be found in README.md

###Study Design
From the original dataset the mean() and std() values for each feature calculation were extracted. Summary calculations which did not have both a mean and an std were left out, i.e. meanFreq and those means used to calculate the angle() variable were not used. In the original data these values are represented for each replicate of each activity conducted by each subject. The subjects are denoted as either 'test' or 'training' to distinguish to which group each subject belongs. The resulting dataset is 'tidy' and represents the means of these values for the replicates of each activity for each subject.

####Features of a tidy dataset
- Each variable is in one column
- Each observational unit of each variable is in a different row
- One table for each "kind" of observation
- Multiple tables should include a column in each which allows the tables to be linked

Files from the original data used in run_analysis.R:  
Files from the Inertial Signals Directories were not used as they contain no summary data.

- UCI HAR Dataset/train/X_train.txt
    - Summary values calculated from the feature values for the training set
- UCI HAR Dataset/test/X_test.txt
    - Summary values calculated from the feature values for the test set
- UCI HAR Dataset/features.txt
    - Feature names corresponding to the summary values in X_train.txt and X_test.txt
- UCI HAR Dataset/test/subject_test.txt
    - The subject identifiers corresponding to their respective measures in X_test.txt
- UCI HAR Dataset/train/subject_train.txt
    - The subject identifiers corresponding to their respective measures in X_train.txt
- UCI HAR Dataset/test/y_test.txt
    - The activity identifiers corresponding to their respective measures in X_test.txt
- UCI HAR Dataset/train/y_train.txt
    - The activity identifiers corresponding to their respective measures in X_train.txt

###Code Book
The columns in the resulting dataset are 'set' which is either 'test' or 'training', 'subject' which denotes the subject by their numeric identifier (1-30), 'activity' which denotes the type of activity and is one of the following: 'Laying', 'Sitting', 'Standing', 'Walking', 'WalkingDown' (walking downstairs), and 'WalkingUp' (walking upstairs). The remaining columns are the means followed by stds of the feature vectors of the 128 sample windows (the values are unitless as they were derived from feature calculations which were normalized to values bounded by [-1,1]), represent the means of the replicates for these values and in order are: 

tBodyAccMeanX, tBodyAccMeanY, tBodyAccMeanZ, tGravityAccMeanX,    tGravityAccMeanY, tGravityAccMeanZ, tBodyAccJerkMeanX, tBodyAccJerkMeanY,   tBodyAccJerkMeanZ, tBodyGyroMeanX, tBodyGyroMeanY, tBodyGyroMeanZ,  tBodyGyroJerkMeanX, tBodyGyroJerkMeanY, tBodyGyroJerkMeanZ, tBodyAccMagMean, tGravityAccMagMean, tBodyAccJerkMagMean, tBodyGyroMagMean,    tBodyGyroJerkMagMean, fBodyAccMeanX, fBodyAccMeanY, fBodyAccMeanZ,   fBodyAccJerkMeanX, fBodyAccJerkMeanY, fBodyAccJerkMeanZ, fBodyGyroMeanX,  fBodyGyroMeanY, fBodyGyroMeanZ, fBodyAccMagMean, fBodyAccJerkMagMean, fBodyGyroMagMean, fBodyGyroJerkMagMean, tBodyAccStdX, tBodyAccStdY,    tBodyAccStdZ, tGravityAccStdX, tGravityAccStdY, tGravityAccStdZ, tBodyAccJerkStdX, tBodyAccJerkStdY, tBodyAccJerkStdZ, tBodyGyroStdX,   tBodyGyroStdY, tBodyGyroStdZ, tBodyGyroJerkStdX, tBodyGyroJerkStdY,   tBodyGyroJerkStdZ, tBodyAccMagStd, tGravityAccMagStd, tBodyAccJerkMagStd,  tBodyGyroMagStd, tBodyGyroJerkMagStd, fBodyAccStdX, fBodyAccStdY,    fBodyAccStdZ, fBodyAccJerkStdX, fBodyAccJerkStdY, fBodyAccJerkStdZ,    fBodyGyroStdX, fBodyGyroStdY, fBodyGyroStdZ, fBodyAccMagStd, fBodyAccJerkMagStd, fBodyGyroMagStd, fBodyGyroJerkMagStd

