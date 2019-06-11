featurenames <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\features.txt")
activitylabels <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt",header= F)
##read Test data
Testsubject <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt", header = F)
Testfeature <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt", header = F)
Testactivity <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt", header = F)
##read Train data
Trainsubject <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt", header = F)
Trainfeature <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt", header = F)
Trainactivity <- read.table("C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt", header = F)
##merge data
subject <- rbind(Testsubject, Trainsubject)
feature <- rbind(Testfeature, Trainfeature)
activity <- rbind(Testactivity, Trainactivity)
colnames(feature) <- t(featurenames[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
cbind(subject, feature, activity)
##extract mean or STD
MeanSTD <- grep(".*Mean.*|.*Std.*", names(MD), ignore.case = T)
MeanSTD
## descriptive activity name
extract1 <- c(MeanSTD, 562,563)
extract2 <- MD[, extract1]
## label dataset
extract2$Activity <- as.character(extract2$Activity)
for (i in 1:6){
  extract2$Activity[extract2$Activity == i] <- as.character(activitylabels[i,2])
}
extract2$Activity <- as.factor(extract2$Activity)
names(extract2) <- gsub("acc","acceleration", names(extract2))
names(extract2) <- gsub("gyro","gyroscope", names(extract2))
## create tidy subset
extract2$Subject <- as.factor(extract2$Subject)
library(reshape)
subpre <- melt(extract2, id.vars=c("Subject","Activity"))
Tidy <- aggregate(subpre, Subject + Activity ~ variable, mean)
write.table(Tidy, file = "C:\\Users\\qitcw\\Desktop\\网课\\JH data science\\3 getting and cleaning data\\getdata%2Fprojectfiles%2FUCI HAR Datase\\Tidy.txt", row.name=F)
