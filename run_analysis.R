###### Script for Course Project for Getting and Cleaning Data  ############

############   STEP ONE    ##############################################################
##Set up Script to acquire the data files in the working environment

scripthome<-getwd()   ##establish the working directory

## Download the Samsung data to subfolder"UCI HAR Dataset" in working directory (if not already there)
setwd(scripthome)
CPdataURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipdest<-"CPzip.zip"
if(!file.exists(zipdest)){
  download.file(CPdataURL,zipdest)
  close.connection(url(CPdataURL))
} 
if(!dir.exists("UCI HAR Dataset")) unzip(zipdest)

##Name shortcuts to change directories
DIRucidataset<-"./UCI HAR Dataset"
DIRtestdata<-"./UCI HAR Dataset/test"
DIRtraindata<-"./UCI HAR Dataset/train"
DIRtestdatainertial<-"./UCI HAR Dataset/test/Inertial Signals"
DIRtraindatainertia<-"./UCI HAR Dataset/train/Inertial Signals"

##Download the data in the folder "test"
setwd(scripthome)
setwd(DIRtestdata)
X_test<-read.table("X_test.txt", header = FALSE, sep = "", dec = ".")
Y_test<-read.table("Y_test.txt", header = FALSE, sep = "", dec = ".")
subject_test<-read.table("subject_test.txt",header = FALSE, sep = "", dec = ".")
setwd(scripthome)

##Download the data in the folder "train"
setwd(scripthome)
setwd(DIRtraindata)
X_train<-read.table("X_train.txt", header = FALSE, sep = "", dec = ".")
Y_train<-read.table("Y_train.txt", header = FALSE, sep = "", dec = ".")
subject_train<-read.table("subject_train.txt",header = FALSE, sep = "", dec = ".")
setwd(scripthome)

##Download the data in the folder "UCI HAR Dataset"
setwd(scripthome)
setwd(DIRucidataset)
features<-read.table("features.txt", header = FALSE, sep = "", dec = ".")
activity_labels<-read.table("activity_labels.txt", header = FALSE, sep = "", dec = ".")
setwd(scripthome)



############   STEP TWO    ##############################################################
## Script to create the wide data set (not yet tidy)

## Create the merged Subject data
subject_frame<-rbind(subject_test, subject_train)
names(subject_frame)<-"subject"

## Create the bariable "type" which indicates whether a subject is in test or train group
test_train_subjects<-c(rep("test", nrow(subject_test)), rep("train", nrow(subject_train)))
type_frame<-data.frame("type"=test_train_subjects)

## Create the activity variable
activity_number<-rbind(Y_test, Y_train)
activity_frame<-data.frame("activity"=inner_join(activity_number, activity_labels, sort=FALSE)[,2])

## Create the Features variables
meanfeature<- grep("mean()", features[,2])
stdfeature<-grep("std()", features[,2])
fullfeatures<-rbind(X_test,X_train)
names(fullfeatures)<-features$V2
goodfeature<-grep("mean...[XYZ]$|std...[XYZ]$|mean..$|std..$", features[,2])
restrictedfeatures_frame<-fullfeatures[,goodfeature]

## Create the wide dataframe
widedata<-cbind(type_frame, subject_frame, activity_frame, restrictedfeatures_frame) %>%
  arrange(subject, activity)





##############  STEP THREE    ############################################################## 
### Convert the wide data into narrow data (tidy)


## melt the wide data
meltid<-names(widedata)[1:3]
meltvars<-names(widedata)[4:ncol(widedataframe)]
moltendata<-melt(widedata,id=meltid, measure.vars=meltvars)
colnames(moltendata)[colnames(moltendata)=="variable"] <- "feature"
moltendata<-arrange(moltendata, subject, activity, feature)

## Break the features into thier components: domain, motion, sensor, jerk, axial, aggregation

###set up the regualar expressions
domainExp<- "^[tf]"
motionExp<- "Body|Gravity"
sensorExp<- "Acc|Gyr"
jerkExp<- "Jerk"
axialExp <- "[XYZ]$|Mag"
aggregationExp<-"mean|std"

### break out the components of "features", rearrange variables, remove NAs and change to factors:
narrowdata<- moltendata %>%
  mutate(domain=str_extract(feature, domainExp), motion=str_extract(feature, motionExp)) %>%
  mutate(sensor=str_extract(feature, sensorExp), jerk=str_extract(feature, jerkExp)) %>%
  mutate(axial=str_extract(feature, axialExp), aggregation=str_extract(feature, aggregationExp)) %>%
  select(-value, everything()) %>%
  select( -feature)
narrowdata[is.na.data.frame(narrowdata)]<-""
narrowdata[,4:9] <- lapply(narrowdata[,4:9], as.factor)

#### change the factor levels to more natural names and reorder the dataset
narrowdata$domain<-recode(narrowdata$domain, t="Time", f="Fourier")
narrowdata$sensor<-recode(narrowdata$sensor, Acc="Accelerometer", Gyr="Gyroscope")
narrowdata$axial<-recode(narrowdata$axial, Mag="Magnitude")
narrowdata<-arrange(narrowdata, subject, activity, desc(domain), sensor, jerk, axial, aggregation)





############   STEP FOUR    ##############################################################  
## Script to create the tidy data set for part 5); name it summarytidydata

## group the data in finaldataframe by subject and activity and summarize the data with mean

tidysummary<-narrowdata %>% 
  group_by(subject, activity, domain, motion, sensor, jerk, axial, aggregation) %>%
  summarize(average=mean(value)) 


