#setwd("Dropbox/Coursera/Exploratory Data Analysis")
library(lubridate)
library(dplyr)
power<-read.table("household_power_consumption.txt", header=TRUE, sep=";",na.strings="?")
power$Date <- as.Date(power$Date,"%d/%m/%Y")
DateTime <- strptime(power$Time,"%H:%M:%S")
month(DateTime)<-month(power$Date)
year(DateTime)<-year(power$Date)
day(DateTime)<-day(power$Date)
DateTime<-as.POSIXct(DateTime)
power$DateTime<-DateTime
okdates <- as.Date(c("2007-02-01","2007-02-02"))
power2<-filter(power,power$Date %in% okdates)

png(filename="plot4.png",width=480,height=480)
par(mfrow=c(2,2))

plot(power2$DateTime, power2$Global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(power2$DateTime, power2$Voltage,type="l",ylab="Voltage",xlab="datetime")

plot(x=power2$DateTime, y=power2$Sub_metering_1, type="n",ylab="Energy sub metering",xlab="")
lines(power2$DateTime,power2$Sub_metering_1,col="black")
lines(power2$DateTime,power2$Sub_metering_2,col="red")
lines(power2$DateTime,power2$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black","red","blue"))

plot(power2$DateTime, power2$Global_reactive_power,type="l",ylab="Global Reactive Power",xlab="")

dev.off()