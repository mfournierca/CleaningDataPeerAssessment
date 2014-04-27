#code for the peer assessment of the course Getting and Cleaning Data of the 
#Coursera Data Science Specialization. 
#Course details can be found at: https://class.coursera.org/getdata-002

runAnalysis <- function(dataZip="getdata-projectfiles-UCI HAR Dataset.zip") {

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
  
  
}