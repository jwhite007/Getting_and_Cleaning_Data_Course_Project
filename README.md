An Explanation of run_analysis.R
=
The Data
-
[Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The Script
-
run_analysis.R contains a script which combines the measurements for the test and training sets and extracts the means and standard deviations for those measurements. It then outputs a text file with a tidy data set with the mean of the extracted data for the replicates of each activity within each subject.

Either clone this repository and unzip the included .zip file, or download run_analysis.R from the repository and download the .zip file from here: [the .zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Ensure that both run_analysis.R and the unzipped contents of the .zip file are in your working directory. The uncompressed .zip file will result in a directory named "UCI HAR Dataset" in your working directory.

From R issue "source('run_analysis.R')"
