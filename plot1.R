library(sqldf)

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


## use SQLDF package and write WHERE clause to only bring into memory
## the data that we need
fn <- file("household_power_consumption.txt")
detach("package:RMySQL", unload=TRUE)
df <- sqldf('select * from fn where Date = "2/1/2007" or Date = "2/2/2007"',
            file.format = list(header = TRUE, sep = ";"))

## create histogram and write out as a PNG file with specific size
gab <- as.numeric(df$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(gab, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## important!! close the device
dev.off()

