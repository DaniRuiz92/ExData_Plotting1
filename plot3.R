## Exploratory data analysis
## Project 1 - Plot 3
## Daniel Ruiz


## Creates data directory if it doesn't exists
if (!file.exists("./data")) {
    dir.create("./data")
}

## Download and extract data if it doesn't exists
if (!file.exists("./data/dataset.zip")) {
    fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' ## Data url
    download.file(fileUrl, destfile = "./data/dataset.zip") ## Downloading the data set
    unzip("./data/dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "./data", unzip = "internal",
      setTimes = FALSE) ## Unzip the data set
}

## Reads the data set
data_set <- read.csv2("./data/household_power_consumption.txt")
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))

## Subset data
data_set_use <- subset(data_set, as.POSIXlt(as.Date(data_set$Date, format = "%d/%m/%Y")) == as.POSIXlt(dates[1]) |
                                 as.POSIXlt(as.Date(data_set$Date, format = "%d/%m/%Y")) == as.POSIXlt(dates[2]))
## Delete last data
rm(data_set)

## Set locale in english to avoid x labels in spanish (my computer is in spanish language)
Sys.setlocale("LC_TIME", "English")

## Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(x = strptime(paste(data_set_use$Date, data_set_use$Time, sep = " "), "%d/%m/%Y %H:%M:%S"),
     y = as.numeric(as.character(data_set_use$Sub_metering_1)),
     type = 'l',
     col = 'black',
     xlab = "",
     ylab = 'Energy sub metering')

lines(x = strptime(paste(data_set_use$Date, data_set_use$Time, sep = " "), "%d/%m/%Y %H:%M:%S"),
     y = as.numeric(as.character(data_set_use$Sub_metering_2)),
     col = 'red')

lines(x = strptime(paste(data_set_use$Date, data_set_use$Time, sep = " "), "%d/%m/%Y %H:%M:%S"),
     y = as.numeric(as.character(data_set_use$Sub_metering_3)),
     col = 'blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

dev.off()