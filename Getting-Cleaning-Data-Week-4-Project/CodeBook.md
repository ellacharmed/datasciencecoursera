<!-- a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md -->
# The Code book

The raw data is the result of a study titled **Human Activity Recognition Using Smartphones Dataset Version 1.0** conducted by

    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy.

This study collected data provided by 30 volunteers who performed the six activies listed:

- WALKING,
- WALKING_UPSTAIRS,
- WALKING_DOWNSTAIRS,
- SITTING,
- STANDING,
- LAYING

while wearing a smartphone (Samsung Galaxy S II) on the waist. Each volunteer is given a subject ID and have the data recorded manually by labelling each physical activity. For more detailed explanation, please read **Readme.txt** provided in the `.zip` file from the raw data download.

Following is an excerpt from the Readme.txt file, that came with the raw data in aforementioned `.zip` file, which describes the data in greater detail.

    For each record it is provided:

    - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
    - Triaxial Angular velocity from the gyroscope. 
    - A 561-feature vector with time and frequency domain variables.
    - Its activity label.
    - An identifier of the subject who carried out the experiment.

    The dataset includes the following files:

    - 'README.txt'
    - 'features_info.txt': Shows information about the variables used on the feature vector.
    - 'features.txt': List of all features.
    - 'activity_labels.txt': Links the class labels with their activity name.
    - 'train/X_train.txt': Training set.
    - 'train/y_train.txt': Training labels.
    - 'test/X_test.txt': Test set.
    - 'test/y_test.txt': Test labels.

    The following files are available for the train and test data. Their descriptions are equivalent.

    - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
    - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
    - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

--------------------------------------

## Code design considerations

I've elected to take the 5-steps requirements outlined in [README.md](readme.md) as a whole start-to-finish codeblock instead of a step-by-step instruction manual. As such, the [`run_analysis.R` R script](run_analysis.R) would have the actual code to carry out some of those steps out of order. This is mainly due to the depth of my current knowledge in R Programming and also the constraint of time to explore a more elegant solution vs the need to just "get it done and get it submitted".

An example of this is the decision to label the datasets at the time of loading the data in a data.table versus doing the step *after* merging data sets. Another instance is the decision to subset the Mean and Standard-Deviation columns first *before* merging, thus dealing with smaller resulting data tables.

### Script walkthrough

- Load feature.txt file into `features` data table and label column names as `"featureId", "featureName"`
- Load activity_labels.txt file into `activities` data table and label column names as `"activityId", "activityName"`
- Use RegEx to look for `featureNames` that contain `mean` or `std`, also set as character vector for reuse later
- Load `subject` data for each Train & Test dataset, with appropriately labeled column names
- Load subset of each Train & Test main data set with the subset parameters narrowed by the RegEx expression above. Apply labels as appropriate
- Load the `activityId` data and label as appropriate
- Merge each Train & Test with the respective `activityName` per subject data and combine all
- Merge both Train & Test dataset into one table
- Calculate the average Mean and Standard-Deviation for each subject and activity
- Write this tidy data to file named `tidydata.txt`
