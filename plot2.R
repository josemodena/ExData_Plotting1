# Coursera - Exploratory Data Analysis
# Course Project 1
# Script to generate plot 2

# Download and read the dataset (only dates 2007-02-01 and 2007-02-02)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destFile, method = "curl")
unzip(destFile)
colNames <- read.table("household_power_consumption.txt", 
                          sep = ";", as.is = TRUE,
                          nrows = 1)
consumption <- read.table("household_power_consumption.txt", 
                          sep = ";", col.names = colNames, as.is = TRUE,
                          skip = 66637, nrows = 2880)

# Convert ? to NA
consumption <- as.data.frame(lapply(consumption,
                                    function(x) gsub("?", NA, x, fixed = TRUE)))
consumption$Date <- as.character(consumption$Date)
consumption$Time <- as.character(consumption$Time)
consumption$Global_active_power <- as.numeric(as.character(consumption$Global_active_power))
consumption$Global_reactive_power <- as.numeric(as.character(consumption$Global_reactive_power))
consumption$Voltage <- as.numeric(as.character(consumption$Voltage))
consumption$Global_intensity <- as.numeric(as.character(consumption$Global_intensity))
consumption$Sub_metering_1 <- as.numeric(as.character(consumption$Sub_metering_1))
consumption$Sub_metering_2 <- as.numeric(as.character(consumption$Sub_metering_2))
consumption$Sub_metering_3 <- as.numeric(as.character(consumption$Sub_metering_3))

# Transform Date and Time to R's Date/Time classes
dateTime <- paste(consumption$Date, consumption$Time)
consumption$Date <- as.Date(dateTime, format = "%d/%m/%Y %H:%M:%S")
consumption$Time <- strptime(dateTime, format = "%d/%m/%Y %H:%M:%S")

# Make plot
png(filename = "plot2.png", 
    width = 480, height = 480)

plot(consumption$Time, consumption$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type = "l")

dev.off()
