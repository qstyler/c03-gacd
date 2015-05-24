# Getting and Cleaning Data
## Data Science specialization

### Course Project


You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Steps to work on this course project

1. Clone this repo by typing in your console (not R console)    
`git clone https://github.com/qstyler/c03-gacd.git`

2. Source your ```run_analysis.R``` by either providing full path to the file, or setting your working directory (```setwd()```)  to the repo root folder.

3.  Download course project dataset to your working directory and unzip it. Either manually or by calling ```get_data()``` function in your **R** console.

4. Call ```run_analysis()``` to get ```tidy_data.txt``` file in your working directory.


Data file ```tidy_data.txt``` and ```UCI HAR Dataset``` folder are ignored by git.