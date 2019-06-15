# Code_book
This codebook provides information on the variables in the data sets in the course project

## Variables related to the subjects

A series of observations of the motion of a Samsung Galaxy smartphone were conducted for 30 subjects conducting 6 activities. Variables relating to the subjects and their activities are as follow:

**type**
A factor variable with two levels: *test* and *train*. Reflects whether the subject was placed in the test group or the training group.

**subject** 
An integer variable between 1 and 30 indicating the subject being measureed.

**activity**
A factor variable with six levels indicating the activity being measured. The levels are:
*"LAYING", "SITTING","STANDING", "WALKING", "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"*

## Variables related to the features

The experiment was conducted by capturing 28 signals which were converted to a measure vector of "features". The differentiators of these features are variables of the data set. These variable are as follows:

**domain**: A factor variable with two levels, *Time* and *Fourier*. Indicates whether a Fast Fourier Transform was applied to the signals (*Fourier*) or not (*Time*)

 **motion**: A factor variable with two levels, *Body* and *Gravity* indicating the source of the motion. (In the event of Jerk motions the notation in the original feature may be indicated as "BodyBody

 **sensor**: A factor variable with two levels, *Accelerometer* and *Gyroscope* indicating which of the smartphone's sensors captured the signals. 

 **jerk**: A factor variable with two levels, *Jerk"* or "". Some measurements were derived as the body linear acceleration and angular velocity were derived in time to obtain jerk signals. These measurements are indicated as *Jerk*. 

 **axial**: A factor variable with 4 levels: *X*, *Y*, *Z* and *Magnitude*. Measurements performed for each of three axial directections (*X, Y* and *Z*) are indicated with their axial direcetion. *Magnitude* indicates the Euclidean norm of the three axial directions. 

 **aggregation**: A factor variable with two levels: *mean* and *std*. The 28 timed intervals with several sorts of aggregation. THis variable indicates whether the aggregation was a mean (*mean*) or standard deviation (*std*). 
 
 ## Variable indication the value of the measurement

**value**: a numeric variable between -1 and 1 indicating the value of the measure indicated by the feature variables. THe measure of each feature were normalized to the range -1 to 1, and the *value* variable indicates the result of this normalization for the feature indicated by the feature variables for the particular observation
