#CodeBook

Describes the variables, the data, and all transformations and work that were performed to clean up the data. 

##Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## File ```run_analysis.R``` description

### Dependencies
Note that ```run_analysis``` depends on ```dplyr``` package and you must have it in order to run the actual analysis. If it's installed but not loaded, the script will load it by itself.

### Global Variables
* ```dsroot``` — name of the root folder for the data source.
* ```desired_features``` — desired measurements (features) of the whole data set.
* ```observations``` — folders with data to be parsed, processed and merged. Can be set to both “test” and “train” for final run. Or just to “test” for testing purposes.

### Functions
* ```get_data``` — downloads and stores data in your current working directory
* ```run_analysis``` — runs the actual analysis


### Workflow

```run_analysis()``` has all helping functions inside of itself to keep the global scope clean.
 
1. Loads and sanitize the labels and column names into labels variable. Regular expression  replacing all non-alphanum characters with dots.   
2. Runs ```load_observation``` on each of the observation folder to gather and tidyfy all data into ```tidy``` variable.
3. Groups and averages tidy data into average (independent tidy data set) variable.
4. Writes both data sets to corresponding files.

### Output
* ```tidy_data.txt``` — tidy data from all observations.
* ```average_data.txt``` — averaged data.