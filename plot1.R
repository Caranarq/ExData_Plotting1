# System setup
Sys.setlocale(category = "LC_ALL", locale = "C")
library(dplyr)
library(lubridate)
# Read the data
if(!file.exists("Fhousehold_power_consumption.zip")) {
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Fhousehold_power_consumption.zip", mode = "wb")
}
unzip("Fhousehold_power_consumption.zip")
raw <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?", stringsAsFactors = F)
# Basic data cleaning
raw$Date <- dmy(raw$Date)
raw$Time <- hms(raw$Time)
sample <- raw %>% filter(year(Date)==2007 & month(Date)==02) %>% filter(day(Date)==1 | day(Date)==2)
#Build Plot
hist(sample$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power", ask = F)
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()