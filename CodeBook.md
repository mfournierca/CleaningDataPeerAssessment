#Code Book

##Data 

The raw data for this assignment comes from the following URL:

`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` 

##Variables

Most variables are taken from the raw data and are described in the `README.txt` and `features_info.txt` files of the raw data archive. 

The `run_analysis.R` script in this directory parses and combines the test and training data from the raw data set and adds the following variables:

*activityId*: the id of the activity, taken from the `y_text.txt` and `y_train.txt` files in the raw data.

*activityLabel*: the plain text name of the activity being performed on each row of the data set, taken from the `activity_labels.txt` file in the raw data archive. 

*subjectId*: the id of the subject performing the activity on each row of the data, taken from the `subject_text.txt` and `subject_train.txt` files in the raw data archive. 

##Transformations

The following transformations are performed on the data:

- the feature names metadata are read from `features.txt`
- the activity labels metadata are read from `activity_labels.txt`
- for both the test and training data, the following steps are performed: 
  - all the data is read in to a data frame 
  - all columns that are not either a mean or standard deviation are dropped
  - the activity ids are read and added
  - the subject ids are read and added
- the data is then combined using rbind()
- the activity labels are added in their own column using a factor variable

The tidy data is then written into the `output/` folder. 