## set and identify source of data for the plot

sourceRecords <- "source.zip"
sourceUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## check if file is already present
if (!file.exists(sourceRecords)) {
        download.file(sourceUrl,sourceRecords)
}

## check if file has been de-compressed or not
if (!file.exists("household_power_consumption")){
        unzip(sourceRecords)
}

fn <- "household_power_consumption.txt"
data <- read.table(fn, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

## create subset for only those records needed
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

##convert the date
rdate <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
gab <- as.numeric(subSetData$Global_active_power)

png("plot2.png", width=480, height=480)
plot(rdate, gab, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## important!! close the device
dev.off()