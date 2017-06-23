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

sm1 <- as.numeric(subSetData$Sub_metering_1)
sm2 <- as.numeric(subSetData$Sub_metering_2)
sm3 <- as.numeric(subSetData$Sub_metering_3)

png("plot3.png", width=480, height=480)

plot(datetime, sm1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sm2, type="l", col="red")
lines(datetime, sm3, type="l", col="blue")

##create the legend in upper right corner
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

##important!! close the device
dev.off()