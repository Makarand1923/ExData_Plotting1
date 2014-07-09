###########################################################################
# Packages
##########################################################################
packages <- c("data.table")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

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



################## Plot 4 ############################################################
png(filename="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

with(epcData, plot(epcData$DateTime, epcData$Global_active_power, type="l",col="black", xlab="", 
     ylab="Global Active Power (kilowatts)", main=""))

with(epcData, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))

with(epcData, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(epcData, lines(DateTime, Sub_metering_2, col="red"))
with(epcData, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, bty="n", col=c("black","red","blue"))

with(epcData,plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

dev.off()
