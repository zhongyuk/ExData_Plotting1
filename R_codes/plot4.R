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

## Convert variables in dataSub from character class into numeric
dataSub$Global_active_power  <- as.numeric(dataSub$Global_active_power)

dataSub$Sub_metering_1  <- as.numeric(dataSub$Sub_metering_1)
dataSub$Sub_metering_2  <- as.numeric(dataSub$Sub_metering_2)
dataSub$Sub_metering_3  <- as.numeric(dataSub$Sub_metering_3)

dataSub$Voltage  <- as.numeric(dataSub$Voltage)

dataSub$Global_reactive_power   <- as.numeric(dataSub$Global_reactive_power)

## PLOT 4
png("plot4.png",bg = "transparent", width = 480, height = 480)
par(mfrow = c(2,2))

## subplot 1 : Global active power

with(dataSub, plot(date_time,Global_active_power, type = "l",
                   xlab="", ylab = "Global Active Power(kilowatts)"))


## subplot 2 : Voltage

with(dataSub, plot(date_time,Voltage, type = "l",
                   xlab="datetime", ylab = "Voltage"))


## subplot 3 : sub metering 1/2/3
par(xaxt = "s")
with(dataSub, plot(date_time,Sub_metering_1, type = "l", col = "black",
                   ylim = c(0,38), xlab="", ylab = "Energy sub metering"))
par(new = TRUE)

with(dataSub, plot(date_time,Sub_metering_2, type = "l", col = "red",
                   ylim = c(0,38),  xlab="", ylab = "Energy sub metering"))
par(new = TRUE)

with(dataSub, plot(date_time,Sub_metering_3, type = "l", col = "blue",
                   ylim = c(0,38), xlab="", ylab = "Energy sub metering"))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))
par(new = FALSE)


## subplot 4 : Global reactive power

with(dataSub, plot(date_time,Global_reactive_power, type = "l",
                   xlab="datetime", ylab = "Global_reactive_power"))

dev.off()
