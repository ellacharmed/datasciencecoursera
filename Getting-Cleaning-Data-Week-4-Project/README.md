# Instructions for completing the Getting and Cleaning Data Course Project

|  |  |
|------------- | ----------- |  
| **Author**: | Wati Sahnan |
| **Course**: | Getting and Cleaning Data |
| **Specialization**: | Data Science |
| **Institution**: | Johns Hopkins University via Coursera |
 |  |  

This README.md file constitutes the steps on how to get the raw data converted to tidy data based on the Requirements as specified and the definition of Tidy data reproduced below.

The raw data can be downloaded from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Requirements

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Tidy Data Definition

(source: [Hadley Wickham's Tidy Data](https://www.jstatsoft.org/article/view/v059i10))

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

## Steps

1. Download and load the R script into your favourite R editor or terminal and run it. It should be self-contained by typing `source(run_analysis.R)`. In case that fails, the R script can be loaded into R Studio and run it as you would other R scripts.
2. You should get the output file named `tidydata.txt` (in the same working directory as the `run_analysis.R` script file)
3. For information about the variables or actual data descriptions, please read the [CodeBook.md](CodeBook.md)
