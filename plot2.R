## ########################################################### 
## JHU Data Specialization - Exploratory Data Analysis
## Peer Assessment 1
## Plot #2 - Line Graph for Global Active Power
## ########################################################### 

## 1. Reading dataset into R
## 1.1 Check for column classes inside the data file (speeding up read)
tab5rows <- read.table("./Data/household_power_consumption.txt",
                      header = TRUE, nrows = 5,stringsAsFactors=F,sep=';')
classes <- sapply(tab5rows, class)
  
## 1.2 Read all dataset into R - applying column classes read 
fulldataset <- read.table("./Data/household_power_consumption.txt", 
                         header=T, colClasses=classes, sep=';', 
                         na.strings="?",nrows=2075259, check.names=F, 
                         stringsAsFactors=F, comment.char="", quote='\"') 

## 1.3 Subset the data of interest and clearing workspace
data <- subset(fulldataset, as.Date(Date,"%d/%m/%Y") >= as.Date("01/02/2007","%d/%m/%Y") & 
                  as.Date(Date,"%d/%m/%Y") <= as.Date("02/02/2007","%d/%m/%Y"))
rm(fulldataset)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateEff = as.POSIXct(paste(data$Date,data$Time))

## Making Plots - All files names corresponds to the plot
png("plot2.png")
plot(x=data$DateEff, y=data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()



## This function checks for existing data directory and download
## required zipfile and unzip it after download
downloadfileFromURL <- function() {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filename <- "household_power_consumption.zip"
  directory <- "data"
  
  ## Check data directory & create it if doesn't
  if (!file.exists(directory)){
    dir.create(directory)
  }
  
  ## Check file existing in data directory - proceed to 
  ## download if does't exist
  fullPath <- paste(directory,filename,sep="/")  
  if (!file.exists(fullPath)){
    download.file(fileurl, destfile = fullPath, method="curl")
    dateDownloaded <- date()
    unzip("data/household_power_consumption.zip",exdir="data")
    
    msg <- "file downloaded and unzipped"
  }
  else {
    msg <- "file exists in data folder, proceed to use saved file"
  }    
}
