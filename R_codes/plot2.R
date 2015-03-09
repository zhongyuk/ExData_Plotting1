## set work space to the folder where data is saved:@ local repo folder
setwd("C:/Users/zhongyu/Desktop/exdata-data-household_power_consumption")

## Using data.table to read this data can be much faster
library(data.table)
data = fread("household_power_consumption.txt",sep=";",na.strings="?",colClasses="character")

## Subseting the data on the particular dates: 2007 Feb 1 and 2007 Feb 2
dataSub <- subset(data, (data$Date == "1/2/2007") | (data$Date == "2/2/2007"))

## Remove original data to save memory
rm(data)

dataVals <- names(dataSub)

## Extract date and time and put together
Data_date  <- dataSub$Date
Data_time <- dataSub$Time

date_time  <- paste(Data_date, Data_time, sep = " ")

date_time  <- as.POSIXlt(date_time, format = "%d/%m/%Y %H:%M:%S")

## Convert global_active_power from character class into numeric
dataSub$Global_active_power  <- as.numeric(dataSub$Global_active_power)

## PLOT 2 
p2  <- png("plot2.png",bg = "transparent", width = 480, height = 480)

with(dataSub, plot(date_time,Global_active_power, type = "l",
                   xlab="", ylab = "Global Active Power(kilowatts)"))
p2  <- dev.off()
