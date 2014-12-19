Code Book
=

Date data set downloaded: Dec 08 2014

system.time(data.frame(matrix(scan('UCI HAR Dataset/train/X_train.txt'), 4124472 / 561, 561, byrow = TRUE)))  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user  system elapsed  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9.705   0.153  10.739

system.time(read.table('UCI HAR Dataset/train/X_train.txt'))  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;user  system elapsed  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33.874   0.247  34.340
