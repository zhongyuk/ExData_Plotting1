## This piece of code read in data, and plot plot1.png

## set work space to the folder where data is saved:@ local repo folder
setwd("C:/Users/zhongyu/ExData_Plotting1/exdata-data-household_power_consumption")

## Using data.table to read this data can be much faster
library(data.table)
data = fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")

## Subseting the data on the particular dates: 2007 Feb 1 and 2007 Feb 2
dataSub <- subset(data, (data$Date == "1/2/2007") | (data$Date == "2/2/2007"))

## Remove original data to save memory
rm(data)

dataVals <- names(dataSub)


## PLOT 1
## Convert global_active_power from character class into numeric
dataSub$Global_active_power  <- as.numeric(dataSub$Global_active_power)

## Draw histogram over global_active_power
png("plot1.png", bg = "transparent", width = 480, height = 480)
with(dataSub,hist(Global_active_power, breaks = 12, col = "red",
                  main = "Global Active Power",
                  xlim = c(0,6), ylim = c(0,1200),
                  xlab = "Global Active Power (kilowatts)"), ylab = "Frequency")
dev.off()