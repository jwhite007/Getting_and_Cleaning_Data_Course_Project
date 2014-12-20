#An Explanation of run_analysis.R

##The Original Data

[Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The original data is in samsung_data.zip included in the repository. Details about the data can be found in CodeBook.md

Files from the original data used in run_analysis.R

- UCI HAR Dataset/train/X_train.txt
- UCI HAR Dataset/test/X_test.txt
- UCI HAR Dataset/features.txt
- UCI HAR Dataset/test/subject_test.txt
- UCI HAR Dataset/train/subject_train.txt
- UCI HAR Dataset/test/y_test.txt
- UCI HAR Dataset/train/y_train.txt

##The Script

run_analysis.R contains a script which combines the measurements for the test and training sets from the origianl data and extracts the means and standard deviations for those measurements. It then outputs a text file with a tidy dataset with the mean of the extracted data for the replicates of each activity for each subject.

- Clone this repository and unzip the included zip file. If you've previously obtained the zip file from elsewhere, you can just download run_analyis.R into the directory which contains the uncompressed contents of the zip file.

- Ensure that both run_analysis.R and the unzipped contents of the .zip file are in your working directory. The uncompressed .zip file will result in a directory named "UCI HAR Dataset" in your working directory.

- Ensure that the dplyr package is installed in your R version.

- From R issue "source('run_analysis.R')"

###Details
1. Functions from the dplyr package are used and so dplyr is loaded.

2. The raw data from test and training sets are each scanned into a separate data frame. A 'set' column with values of either 'test' or 'training' is appended to each data frame with cbind(). The resulting data frame now consists of a 'set' column and a column for each of the measurements explained in the CodeBook. The inertial signals are not used as they will not be needed for the final output.

    Using scan() to first put the data into a matrix and then converting that matrix into a data frame is approximately 70% faster than using read.table(). The only drawback is that one must first determine the dimensions of the data being scanned in. fread() from the data.table package would have been used to determine if it would have improved the performance even further, unfortunately, fread() on my system, Mac OSX, crashes R (data.table version 1.9.4, R version 3.1.2, Mac OSX version 10.10.1).
    >system.time(data.frame(matrix(scan('UCI HAR Dataset/train/X_train.txt'), 4124472 / 561, 561, byrow = TRUE)))  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user  system elapsed  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9.705   0.153  10.739
    >system.time(read.table('UCI HAR Dataset/train/X_train.txt'))  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user  system elapsed  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33.874   0.247  34.340

3. The two data frames are then merged together with rbind(). Column names for the features columns are labeled with a readLines() of features.txt.

4. Dplyr's chaining functionality is used to create a tidy dataset and does the following.

    1. Two columns are appended with cbind(). One labeled 'subject' is created by reading in the subject identifiers from subject_test.txt and subject_train.txt in conjunction. Another labeled 'activity' is created by reading in the activity identifiers from y_test.txt and y_train.txt in conjunction. These identifiers are explained in the CodeBook.

    2. The select function from dplyr is used to extract only data which is the mean and std of the feature measurements. Upon select the columns are orderd 'set', 'subject', 'activity' followed by the means for the various measurements, followed by the stds for the various measurements.

    3. The data is grouped by set, followed by subject, followed by activity. This ensures a mean calculation of the activity replicates for each subject using summarise_each().

    4. The data is then ungrouped.

5. All intermediate data frames are removed from the user's workspace at this point.

6. At this point the activity column consists of numeric identifiers as explained in the CodeBook. These identifiers in the 'activity' column are converted to descriptive identifiers such as 'walking up'.

7. The sub function is then used to "clean up" the column names of the feature measurements and to make those names syntactically valid to R.

8. The data rows are first sorted by 'set', then by 'subject', then by 'activity' to make the dataset more readable.

9. Finally the data is written to a text file in the user's working directory. This text file can then be viewed with other software such as MicroSoft Excel (must import the text file using 'space' as a delimeter) or read back into R with a function such as read.table(). After sourcing the script, the resulting data frame exists in the user's workspace and can be explored from within R.
