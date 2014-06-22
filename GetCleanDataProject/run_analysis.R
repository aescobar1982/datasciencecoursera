##Set working directory and create folder for data if it does not exist
setwd("C:\\Users\\AEscobar\\Desktop\\CourseraGetCleanData")
if (!file.exists("data")) {
  dir.create("data")
}

##########################################################
##  Merge training and test sets to create one data set ##
##########################################################

##Download data file and unzip files
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile=".\\data\\HARData.zip")
unzip(".\\data\\HARData.zip")

##Load test and train datasets and feature names into data frames
featurenames <- read.table(".\\UCI HAR Dataset\\features.txt")
colnames <- featurenames[,2]
testdataset <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",col.names=colnames)
traindataset <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt",col.names=colnames)
testactivitylabels <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
testsubjectlabels <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
trainactivitylabels <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
trainsubjectlabels <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

##Combine dataset with subject numbers 
testdataset$subjnum <- as.vector(testsubjectlabels$V1)
traindataset$subjnum <- as.vector(trainsubjectlabels$V1)
testdataset$activitynum <- as.vector(testactivitylabels$V1)
traindataset$activitynum <- as.vector(trainactivitylabels$V1)
head(testdataset)
head(traindataset)

##Merge data frames
harData <- rbind(testdataset,traindataset)
head(harData)

################################################
##  Select measurements for means and std dev ##
################################################

#Identify field names for means and std
allFields <- data.frame(fields=names(harData))
allFieldsMean <- grep("\\.mean\\.",tolower(allFields$fields))
allFieldsStd <- grep("\\.std\\.",tolower(allFields$fields))

##Keep only mean and std fields
harDataFinal <- harData[,c(allFieldsMean,allFieldsStd,562,563)]
head(harDataFinal)

############################
##  Apply activity labels ##
############################

##Load activity labels
activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",col.names=c("activitynum","activity_name"))

##Merge dataset with activity labels
harDataFinal2 <- merge(harDataFinal,activitylabels,by.x="activitynum",by.y="activitynum",all=TRUE)

############################################################################
##  Create data set of average of each variable for each subject/activity ##
############################################################################

#Melt data frame and reshape to have one field for variable name and one for value
library(reshape2)
meltHarData <- melt(harDataFinal2,id=68:69,measure.vars=2:67)
meltHarData$variable <- paste(meltHarData$variable,"_mean")

#Summarize over subject number and activity name
harDataMeans <- dcast(meltHarData,subjnum + activity_name ~ variable,mean)

###########################
##  Output tidy data set ##
###########################

write.csv(harDataMeans,file=".\\data\\harDataMeans.csv")