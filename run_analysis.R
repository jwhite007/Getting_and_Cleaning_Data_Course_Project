library(dplyr)
library(tidyr)

ds_train <- data.frame(matrix(scan('UCI HAR Dataset/train/X_train.txt'), 4124472 / 561, 561, byrow = TRUE))
# ds_train <- read.table('train/X_train.txt')
ds_train <- cbind(set = rep('training'), ds_train)
ds_test <- data.frame(matrix(scan('UCI HAR Dataset/test/X_test.txt'), 1653267 / 561, 561, byrow = TRUE))
# ds_test <- read.table('test/X_test.txt')
ds_test <- cbind(set = as.character(rep('test')), ds_test)
ntds <- rbind(ds_test, ds_train)
colnames(ntds) <- c('set', readLines('UCI HAR Dataset/features.txt'))

ds <- cbind('subject' = c(as.numeric(readLines('UCI HAR Dataset/test/subject_test.txt')),
                          as.numeric(readLines('UCI HAR Dataset/train/subject_train.txt'))),
            'activity' = c(scan('UCI HAR Dataset/test/y_test.txt'),
                           scan('UCI HAR Dataset/train/y_train.txt')),
            ntds) %>%
select(set, subject, activity, contains('mean()'), contains('std()')) %>%
group_by(set, subject, activity) %>%
summarise_each(funs(mean)) %>%
ungroup

ds$activity[ds$activity == c(1:6)] <- c('walking', 'walking up', 'walking down', 'sitting', 'standing', 'laying')
colnames(ds) <- sub('()', '', colnames(ds), fixed = TRUE)
colnames(ds) <- sub('[[:digit:]]+ ', '', colnames(ds))
colnames(ds) <- sub('(Body){2}', 'Body', colnames(ds))
ds <- ds[order(ds$set, ds$subject, ds$activity),]
# ds <- cbind(ds[1:3], ds[4:69][, order(names(ds[4:69]))])
write.table(ds, 'ds.txt', row.names = FALSE)
