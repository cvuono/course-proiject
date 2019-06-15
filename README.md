# course-project
Course project repo for Getting and Cleaning Data

This project collects and summarizes data from a study *"Human Activity Recognition Using Smartphones Dataset"*.

## Description of the study and the variables measured

In the study, subjects motion was captured while they wore a Samsung Galaxy Smarthone. The 30 **subjects** were partitioned into a training subset (*train*) and a test subset (*test*) which was labeled as **type**.

The subjects were measured performing six types of **activity**: "*LAYING", "SITTING", "STANDING", "WALKING","WALKING_DOWNSTAIRS",* and *"WALKING_UPSTAIRS"*   

Measurements were made over 28 time periods and captured over two **domains**: a time measurement (*time*) and the result of a Fast Fourier Transform (*Fourier*). 

Measurement was divided into the source of the **motion** *Body* and *Gravitation*

Movement was measured using two **sensors** internal to the smartphone: an *Accelerometer* and a *Gyroscope*.  

Some measurements were derived as the body linear acceleration and angular velocity were derived in time to obtain **jerk** signals. These signals are indicated as *Jerk*

Measurements were performed for each of three **axial** directections (*X, Y* and *Z*) and also the *Magnitude* of the three axial measures using the Euclidean norm. 

Measurements were taken at 28 timed intervals with several sorts of **aggregation**. In this project, we only consider two of these: *mean* and *std* (standard deviation).

## How the data was parsed into *Tidy Data*

