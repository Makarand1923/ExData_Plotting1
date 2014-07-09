

################## Path and File Download  ####################################################
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- "exdata-data-household_power_consumption.zip"

if (!file.exists("exdata-data-household_power_consumption.zip")) {
        download.file(url,file.path(path,f))
        unzip(file.path(path,f),exdir=getwd())
        #download.file(url= url,method="curl")
        #unzip("exdata-data-household_power_consumption.zip")  
}

dataPath <- file.path(path,"household_power_consumption.txt")

#################### Read File ##############################################################
# This huge file so opend in textpad and found out that relevet data for this exercise is from line # 66638 to 69517
# loading only these lines and adding names by reading firstline again.
epcData <- read.csv(dataPath, sep=";", skip=66637,nrows=2880,na.strings = "?", header = FALSE)
names(epcData) <- names(read.csv(dataPath, sep=";",nrows=1))

# Convert first col to date
epcData$DateTime <- as.POSIXct(paste(epcData$Date, epcData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")



################## Plot 1 ############################################################

hist(epcData$Global_active_power, col="#ff2500", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png,filename="plot1.png",width=480, height=480);
dev.off()



