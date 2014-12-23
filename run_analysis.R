# The documentation for this script can be found in the associated README.md

# The following is a script which combines the summary values for the test and
# training sets from the origianl data referenced in README.md and extracts
# the means and standard deviations of the summary feature calculations. It
# then outputs a text file with a tidy dataset with the mean of the extracted
# data for the replicates of each activity for each subject. The
# 'UCI HAR Dataset' directory and run_analysis.R must be present in the user's
# working directory. Its output can be obtained from within R by issuing
# "source('run_analysis.R')" and will result in a data frame, 'ds', in the
# user's workspace and in the user's working directory a txt file,
# 'UCI_HAR_Sub.txt', which contains the resulting data.

# Checks to see if dplyr package is installed. Installs if not installed already:
if (!'dplyr' %in% installed.packages()) {
    install.packages('dplyr')
}

library(dplyr)

# Puts the training data into a dataframe. Using scan() to put the values into a
# matrix and then converting that matrix to a data frame is much faster than
# using read.table():
ds_train <- data.frame(matrix(scan('UCI HAR Dataset/train/X_train.txt'),
                              4124472 / 561, 561, byrow = TRUE))
# Appends a 'set' column to the data frame denoting the 'training' set:
ds_train <- cbind(set = rep('training'), ds_train)
# Puts the test data into a dataframe:
ds_test <- data.frame(matrix(scan('UCI HAR Dataset/test/X_test.txt'),
                             1653267 / 561, 561, byrow = TRUE))
# Appends a 'set' column to the data frame denoting the 'test' set:
ds_test <- cbind(set = rep('test'), ds_test)

# Combines the ds_test and ds_train data frames into one data frame:
cds <- rbind(ds_test, ds_train)
# Assigns 'set' followed by the summary feature names in features.txt to the
# column names of cds:
colnames(cds) <- c('set', readLines('UCI HAR Dataset/features.txt'))

# dplyr chaining functionality
# Appends 'subject' and 'activity' columns based on the values in the
# respective files:
ds <- cbind('subject' = c(as.numeric(readLines('UCI HAR Dataset/test/subject_test.txt')),
                          as.numeric(readLines('UCI HAR Dataset/train/subject_train.txt'))),
            'activity' = c(scan('UCI HAR Dataset/test/y_test.txt'),
                           scan('UCI HAR Dataset/train/y_train.txt')),
            cds) %>%
# Arranges the columns and selects from the features columns only those which
# contain either 'mean()' or 'std()' in the column header:
select(set, subject, activity, contains('mean()'), contains('std()')) %>%
# Groups the columns by set, then by subject, then by activity so that the
# means can be calculated for the summary feature values for the activity
# replicates per subject:
group_by(set, subject, activity) %>%
# Calculates the means for the summary feature values for the activity
# replicates for each subject:
summarise_each(funs(mean)) %>%
# Ungroups the data frame in case grouping interferes with any down-stream
# process:
ungroup

# Removes all intermediate data frames from the user's workspace:
rm('ds_test', 'ds_train', 'cds')

# Changes the activity values from numeric identifiers to descriptive names.
# For the following to be effective, the rows must be arranged by subject and
# then sorted by activity which is achieved by group_by() above:
ds$activity[ds$activity == c(1:6)] <- c('Walking',
                                        'WalkingUp',
                                        'WalkingDown',
                                        'Sitting',
                                        'Standing',
                                        'Laying')

# "Cleans up" the column names of the summary feature columns making them
# look nicer and making them more syntactically valid to R:
colnames(ds) <- sub('-', '',
                    sub('-s', 'S',
                        sub('-m', 'M',
                            sub('(Body){2}', 'Body',
                                sub('[[:digit:]]+ ', '',
                                    sub('()', '', colnames(ds), fixed = TRUE))))))

# Sorts the rows first by 'set', then by 'subject', then by 'activity' so that
# the data is more clear when opened with software such as MicroSoft Excel:
ds <- ds[order(ds$set, ds$subject, ds$activity),]

# Writes the data to a txt file
write.table(ds, 'UCI_HAR_Sub.txt', row.names = FALSE)
