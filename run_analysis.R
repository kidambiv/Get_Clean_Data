library(data.table)
library(plyr)
#Read Activity Label file
ActLabel<-read.table("./UCI HAR Dataset/activity_labels.txt",sep=" ",
                     col.names=c("id","activity"),
                     header=FALSE,na.strings="")
#Read Feature Label file
FeatLabel<-read.table("./UCI HAR Dataset/features.txt",sep=" ",
                      col.names=c("id","feature"),
                      header=FALSE,na.strings="")
#Read Subject Training file
SubTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt",sep=" ",
                      col.names=c("Subject id"),
                      header=FALSE,na.strings="")
#Read Activity Training file
ActTrain<-read.table("./UCI HAR Dataset/train/y_train.txt",sep=" ",
                     col.names=c("Activity id"),
                     header=FALSE,na.strings="")
#Read Training Data file
TrainData<-read.fwf("./UCI HAR Dataset/train/X_train.txt",sep="",
                    colClasses=c(rep("numeric")),widths=8976,
                    header=FALSE,na.strings="",fill=TRUE)
#Label Colnames of Training Data file
flm<-as.matrix(FeatLabel)
names(TrainData)<-c(flm[,2])
#Add Subject, ActivityID to TrainData  dataset
TrainData<-cbind(SubTrain,ActTrain,TrainData)
#Read Subject Test file
SubTest<-read.table("./UCI HAR Dataset/test/subject_test.txt",sep=" ",
                     col.names=c("Subject id"),
                     header=FALSE,na.strings="")
#Read Activity Test file
ActTest<-read.table("./UCI HAR Dataset/test/y_test.txt",sep=" ",
                     col.names=c("Activity id"),
                     header=FALSE,na.strings="")
#Read Test Data file
TestData<-read.fwf("./UCI HAR Dataset/test/X_test.txt",sep="",
                    colClasses=c(rep("numeric")),widths=8976,
                    header=FALSE,na.strings="",fill=TRUE)
#Label Colnames of Test Data file
names(TestData)<-c(flm[,2])

#Add Subject, ActivityID to TestData  dataset
TestData<-cbind(SubTest,ActTest,TestData)

#Merge Test and Training data
mergedData = rbind(TrainData,TestData)

#Extract only mean and stdDev 
a<-grep("mean",colnames(mergedData),ignore.case=TRUE)
b<-grep("std",colnames(mergedData),ignore.case=TRUE)
subData<-subset(mergedData,select=c(1,2,a,b))

# Label Activity names by merging data sets
mergedData2=merge(subData,ActLabel,by.x="Activity.id",by.y="id",all=TRUE)

#Calcuate mean of each column by Activity ID and Subject ID
tidy<-ddply(mergedData2, .(mergedData2$Activity.id, mergedData2$Subject.id), 
            colwise(mean))
TidyData=merge(tidy,ActLabel,by.x="mergedData2$Activity.id",by.y="id",all=TRUE)

#Final Tidy Data set with mean of each collumn by Activity ID, Subject ID 
TidyData=subset(TidyData,select=-c(activity.x))

#Upload Tidy Data to .txt file
write.table(TidyData, "G:/Coursera/Get_Clean_Data/TidyData.txt", sep=",")
