library(dplyr)

ds_train <- data.frame(matrix(scan('UCI HAR Dataset/train/X_train.txt'),
                              4124472 / 561, 561, byrow = TRUE))
ds_train <- cbind(set = rep('training'), ds_train)
ds_test <- data.frame(matrix(scan('UCI HAR Dataset/test/X_test.txt'),
                             1653267 / 561, 561, byrow = TRUE))
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

rm('ds_test', 'ds_train', 'ntds')

ds$activity[ds$activity == c(1:6)] <- c('walking',
                                        'walking up',
                                        'walking down',
                                        'sitting',
                                        'standing',
                                        'laying')
colnames(ds) <- sub('-', '',
                    sub('-s', 'S',
                        sub('-m', 'M',
                            sub('(Body){2}', 'Body',
                                sub('[[:digit:]]+ ', '',
                                    sub('()', '', colnames(ds), fixed = TRUE))))))

ds <- ds[order(ds$set, ds$subject, ds$activity),]

write.table(ds, 'ds.txt', row.names = FALSE)
