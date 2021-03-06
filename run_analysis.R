## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Load dplyr package if not loaded yet
if (!require("dplyr")) {
    install.packages("dplyr")
    require("dplyr")
}

# Set up some project specific constants
dsroot           <- "UCI HAR Dataset"
desired_features <- c("mean", "std")
#observations     <- c("test")
observations     <- c("test", "train")

# Just a little helper to load and unpack the data if you're too lazy
get_data <- function() {
    dataurl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    tmpfile  <- tempfile()

    download.file(dataurl, tmpfile, method="curl")

    unzip(tmpfile)
}


run_analysis <- function() {

    load_observations <- function(folder) {
        data_names <- c("X", "y", "subject")
        make_path <- function(file) {
            file.path(dsroot, folder, paste(file, folder, sep="_") %>% paste("txt", sep="."))
        }

        # reads data as tables from the list of files
        res <- sapply(make_path(data_names), read.table)

        # sets understandableeasily accessable names to the list of tables
        names(res) <- data_names

        # setting the column names based on labels
        names(res$X) <- labels$features
        # leaving only neccessary columns (mean and std)
        res$X <- res$X[,grepl(paste(desired_features, collapse="|"), labels$features)]

        #replace activity codes with actual names
        names(res$y) <- c("activity")
        res$y <- mutate(res$y, activity = labels$activity_labels[activity])

        # tidyfy!
        names(res$subject) = c("subject")

        # return merged by columns result
        cbind(res$subject, res$y, res$X)
    }

    # load labels and column names into factors
    labels <-
        c("activity_labels", "features") %>%
        sapply(
            (function(activity) {
                file.path(dsroot, paste(activity, "txt", sep=".")) %>%
                    read.table(col.names=c("code", "label")) %>%
                    tbl_df %>%
                    select(label) %>%
                    collect %>%
                    .[["label"]] %>%
                    gsub(pattern = "\\W+", replacement = ".")
            })
        )

    # load tidy data
    tidy    <- lapply(observations, "load_observations") %>% do.call(what = rbind)

    # get average data
    average <- group_by(tidy, subject, activity) %>% summarise_each(funs(mean))

    # write data to the text files
    write.table(tidy,    file = "./tidy_data.txt",    row.name = FALSE)
    write.table(average, file = "./average_data.txt", row.name = FALSE)
}




