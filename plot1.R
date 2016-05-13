## Exploratory data analysis
## Project 1 - Plot 1
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

## Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(data_set_use$Global_active_power)), breaks = 15, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()