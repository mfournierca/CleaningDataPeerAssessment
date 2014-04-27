#code for the peer assessment of the course Getting and Cleaning Data of the 
#Coursera Data Science Specialization. 
#Course details can be found at: https://class.coursera.org/getdata-002

runAnalysis <- function(dataZip="getdata-projectfiles-UCI HAR Dataset.zip") {

  #
  # preparation and sanity checks
  #
  
  #ensure that the data is in the working directory
  if (!file.exists(dataZip)) {
    print(paste("data set does not exist: ", dataZip, sep=""))
    return
  }
  
  #create the temp directory
  if (!file.exists("tmp")) {
    dir.create("tmp")
  }
  
  #unzip the data
  if (!file.exists("tmp/UCI HAR Dataset")) {
    unzip(dataZip, exdir="tmp/")
  }

  dataRoot = "tmp/UCI Har Dataset"
  
  #
  # read meta data
  #
  
  #read the feature names (column names)
  f <- read.csv(paste(dataRoot, "features.txt", sep="/"), 
                    sep=" ", header=FALSE)

  #we are only keeping mean and stddev data
  keepCols <- f[grep("-mean|-std", f$V2),]
  
  #read the activity names
  a <- read.csv(paste(dataRoot, "activity_labels.txt", sep="/"), 
                        header=FALSE)
  #
  #read the test data
  #
  
  #The test data. According to the README.txt, the column names are provided
  #by the features.txt file. Columns are 16 characters wide. 
  
  print("reading test data, this may take a while ...")
  testData <- read.fwf(paste(dataRoot, "test/X_test.txt", sep="/"), 
                    rep(16, length(f$V2)), header=FALSE, col.names=f$V2)
  
  testData = testData[, keepCols$V1]
  
  print("reading test activity labels")
  testLabels <- read.csv(paste(dataRoot, "test/y_test.txt", sep="/"), 
                          header=FALSE)
  
  print("reading test subjects")
  testSubjects <- read.csv(paste(dataRoot, "test/subject_test.txt", sep="/"), 
                            header=FALSE)
  
  print("adding test subjects and activity labels")
  testData$activityId = testLabels$V2
  testData$subjectId = testSubjects$V1

  #
  #read the train data
  #
  
  #The training data. According to the README.txt, the column names are provided
  #by the features.txt file. Columns are 16 characters wide. 
  
  print("reading training data, this may take a while ...")
  trainData <- read.fwf(paste(dataRoot, "train/X_train.txt", sep="/"), 
                       rep(16, length(f$V2)), header=FALSE, col.names=f$V2)
  
  trainData = trainData[, keepCols$V1]
  
  print("reading training activity labels")
  trainLabels <- read.csv(paste(dataRoot, "train/y_train.txt", sep="/"), 
                         header=FALSE)
  
  print("reading training subjects")
  trainSubjects <- read.csv(paste(dataRoot, "train/subject_train.txt",sep="/"), 
                           header=FALSE)
  
  print("adding training subjects and activity labels")
  trainData$activityId = trainLabels$V2
  trainData$subjectId = trainSubjects$V1
  
  #
  # combine the data
  #
  print("combining test and training data")
  combinedData <- rbind(testData, trainData)
  
  #
  #assign activity labels
  #
  combinedData$activityLabel <- factor(t$activityLabels, levels=a$V1, labels=a$V2)
  
  #
  # output
  #
  
  #create the output directory
  if (!file.exists("output")) {
    dir.create("output")
  }
  
  print("writing output data")
  write.table(combinedData, "output/output.txt", sep="\t")
}
