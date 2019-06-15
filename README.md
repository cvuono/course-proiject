# course-project
Course project repo for Getting and Cleaning Data

This project collects and summarizes data from a study *"Human Activity Recognition Using Smartphones Dataset"*.

## Description of the study and the variables measured

In the study, subjects motion was captured while they wore a Samsung Galaxy Smarthone. The 30 **subjects** were partitioned into a training subset (*train*) and a test subset (*test*) which was labeled as **type**.

The subjects were measured performing six types of **activity**: "*LAYING", "SITTING", "STANDING", "WALKING","WALKING_DOWNSTAIRS",* and *"WALKING_UPSTAIRS"* 

Measurements were made over 28 time periods and captured in a long list of **features**. These features have many componenets as follows:

 **domain**: Measurements were calculated over two **domains**: a time measurement (*time*) and the result of a Fast Fourier Transform (*Fourier*). 

 **motion**: Measurement was divided into the source of the **motion** *Body* and *Gravitation*

 **sensor**: Movement was measured using two **sensors** internal to the smartphone: an *Accelerometer* and a *Gyroscope*.  

 **jerk**: Some measurements were derived as the body linear acceleration and angular velocity were derived in time to obtain **jerk** signals. These signals are indicated as *Jerk*

 **axial**: Measurements were performed for each of three **axial** directections (*X, Y* and *Z*) and also the *Magnitude* of the three axial measures using the Euclidean norm. 

 **aggregation**: Measurements were taken at 28 timed intervals with several sorts of **aggregation**. In this project, we only consider two of these: *mean* and *std* (standard deviation).

## How the data was parsed into *Tidy Data*

The R script in this repo, *run_analysis.R*, contains code to download and parse the data into various forms. 

A description of this process is as follows:

  **Step One**: Downloading the Data
  The script determines if the data is already prsent in the working directory. If not, the data is downloaded from the UCI machine learning website and is placed in the working directory in a folder called *UCI HAR Dataset*. 

  **Step Two**: Creating the wide data set *widedata*
  The script creates a wide data set with three variables describing the subect and their activity (*type*, *subject*, and *activity*) and each of the features as individual variables. This was achieved through various joins and merges of  the individual data sets downloaded in Step 1. In particular using `rbind` to merge the test and the train data, `inner_join` to apply names to the acitivy numbers, `cbind` to merge the data sets and `grep` to limit to features measuring mean and standard deviation. The reulting wide data set *widedata* has 10,299 rows and 69 columns. 
  
  **Step Three**: Creating the narrow data set *narrowdata*
  The wide data set *widedata* was made narrow by using `melt`.  This took wide selection of *feature variables* and converted them to a single varriable *features* with a single variable indicating the measure called *value*. 
  Subsequently, the resultant *feature* variable was divided into the measurement components described above using `substr`. 
  Finally, the data was made clearer and tidy by changing factors to more natural level names and appropriately rearranging and selecting variables.
  The reulting narrow data set *narrowdata* has 679,734 rows and 10 columns. 
  
   **Step Four**: Creating the tidy summary data set *tidysummary*
  The tidy summary data set *tidysummary* was created from the narrow data set *narrowdata* by using the `group_by` funciton to group the data by *subject* and *activity*. (Note: since we used the narrow data set, the variables related to the meausre features were also included in the group_by call.). The data was summarized into a mean by *subject* and *activity* using `summarize`. 
  The reustling tidy data set "tidysummary" has 11,880 rows and 9 columns.  
  
  ## Comment regarding tasks of the Course Project
  Steps 1 -3 accomplish the first four tasks of the Course project and place the output into the narrow data set *narrowdata*. Task 5 of the Course Project is accomplished in Step 4 with the output placded in the tidy data set *tidysummary*. the file *tidysummary.txt* is uploaded to this repo. 
  
  
