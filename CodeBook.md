This repository contains a R Script "run_analysis.R" which performs the series of steps to get clean, tidy data 
from raw training and test data of  Samsung Galaxy S accelerometers.

Section 1 - Gather Label data information

1. Read Activity and Feature label files for cross referencing and store in dataframes "ActLabel" and "FeatLabel".
2. The data frames are labeled with appropriate column names.

Section 2 - Gather and clean train and test data

1. Read and merge  Subject, Activity, Training Data file into dataframes "SubTrain", "ActTrain" & "TrainData" 
for further data analysis.
2. Label the "TrainData" data frame appropriately using the "FeatLabel" dataset from Section 1 above.
3. Repeat the above steps 1, 2 for Test Data collected and store them in dataframes "SubTest", "ActTest" & "TestData".
4. After above steps, "TrainData" and "TestData" will contain labelled information along with Subject and Activity ID.

Section 3 - Merge Train and test data

1. Merge "TrainData" and "TestData" into new data frame "mergedData"

Section 4 - Extract only Mean and Std Dev columns with labelled activities

1. Select columns containing mean and std dev information by using 'grep' 
2. Create a new data frame "subData" (subset of "mergedData") containing only information selected in step 1.
3. Merge "subData" and "ActLabel" data to label the activity appropriately. Labeled data frame will be under "mergedData2"

Section 5 - Tidy Data Set

1. Calculate average of each column for each activity ID and subject ID by using ddply function from plyr package.
2. Write the final dataframe in "TidyData" in .txt file "TidyData.txt".
