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
grp <- as.numeric(subSetData$Global_reactive_power)
voltage <- as.numeric(subSetData$Voltage)
sm1 <- as.numeric(subSetData$Sub_metering_1)
sm2 <- as.numeric(subSetData$Sub_metering_2)
sm3 <- as.numeric(subSetData$Sub_metering_3)

png("plot4.png", width=480, height=480)
##set the grid
par(mfrow = c(2, 2)) 

plot(rdate, gab, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(rdate, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(rdate, sm1, type="l", ylab="Energy Submetering", xlab="")
lines(rdate, sm2, type="l", col="red")
lines(rdate, sm3, type="l", col="blue")

plot(datetime, grp, type="l", xlab="datetime", ylab="Global_reactive_power")

##create the legend in the upper right norner
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

##important!! close the device
dev.off()