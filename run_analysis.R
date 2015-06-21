library(data.table)
## This function merges files train test and features in sigle dataset
run_analysis <- function()
{
  
  setwd('D:\\DataScience Specialization\\Course3Dataproject\\UCI HAR Dataset')

  ## Read variable names
  namesOriginal<- read.delim2("features.txt", header = FALSE, sep = " ", quote = "\"",
                     dec = ".", fill = TRUE, comment.char = "");
  
  names<-make.names(t(namesOriginal[2]), unique = TRUE)


  ## Read x_test File
  x_test<- read.table("test\\X_test.txt",col.names=names);
  
  
  ## Read subject File
  subjectTest <- read.table("test\\subject_test.txt",col.names=c("subject"));
  
 
  ## Read Activity File
  ActivityTest <- read.table("test\\y_test.txt",col.names=c("Activity"));
  
  ##Merge Columns
  MergedXtest<- cbind(subjectTest,ActivityTest,x_test);

  
  
  
  ## Read x_train File
  x_train<- read.table("train\\X_train.txt",col.names=names);
  
  
  ## Read subject train File
  subjectTrain <- read.table("train\\subject_train.txt",col.names=c("subject"));
  
  
  ## Read Activity train File
  ActivityTrain <- read.table("train\\y_train.txt",col.names=c("Activity"));
  
  ##Merge Columns
  MergedXTrain<- cbind(subjectTrain,ActivityTrain,x_train);
  MergedData<-rbind(MergedXTrain,MergedXtest)
  
  ##Get mean and sdt col names
 

  colnames<-names[grep("(mean|std)", names)];
  ## append subject e actitivity col names
  
  
  ## calculate the average by subject and activity
  md<-MergedData[,colnames];
  l<- list(subject = MergedData$subject, Activity = MergedData$Activity);
  Tidydata <- aggregate(by=l, x =  md, FUN = mean,na.rm=TRUE);
  write.table(Tidydata,row.name=FALSE,file = "tidydata.txt");
}
    




