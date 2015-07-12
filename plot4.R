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
par(mfrow = c(2,2))
#topleft
plot(sample$Global_active_power, type = "l", xlab = "", xaxt = "n", ylab = "Global_active_power")
axis(side = 1, labels = c("Thu", "Fri", "Sat"), at = c(0, 1450, 2900))

#topright
plot(sample$Voltage, type = "l", xlab = "datetime", xaxt = "n", ylab = "Voltage")
axis(side = 1, labels = c("Thu", "Fri", "Sat"), at = c(0, 1450, 2900))

#bottomleft
lgnd <- colnames(sample[7:9])
plot(sample$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(sample$Sub_metering_1, col = "black")
lines(sample$Sub_metering_2, col = "red")
lines(sample$Sub_metering_3, col = "blue")
legend("topright", legend = lgnd, lty = "solid", col = c("black", "red", "blue"), bty = "n", y.intersp = 0.9, cex = 0.8)
axis(side = 1, labels = c("Thu", "Fri", "Sat"), at = c(0, 1450, 2900))
#bottomright
plot(sample$Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n", ylab = "Global_reactive_power")
axis(side = 1, labels = c("Thu", "Fri", "Sat"), at = c(0, 1450, 2900))
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()